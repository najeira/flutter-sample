# flutter_sample

Flutterでアプリを作るアーキテクチャの一例

# ディレクトリ構造

- app
  - pages
  - widgets
  - handlers
  - helpers
- domain
  - models
  - services
- infra
  - remote
  - shared_preference
  - device_info

## app

UIに関連するコード。

### pages, widgets

pagesは画面、widgetsはパーツやコンポーネントを置く。

Flutterでは画面とパーツに大きな違いはないが、
人間の認識では違うものなので、なんとなく分けておく。

依存: handlersとhelpersに依存する。domainやinfraを直接使うことはない。

### handlers

UIからの入力を受け付ける。

アプリケーションのロジックを書く場所。
アプリ/UIに近いロジックを書き、
domain/servicesにあるドメインロジックを使う。

イベント `Notification` が通知されてくるので、
必要に応じてserviceに処理をさせる。
状態とイベントを合成することでserviceへの入力になる。

状態は持たず、Providerによって親から提供された状態を得る。

このため、Widget treeのことは知っている。
UIを構築はしないがWidgetやFlutterには依存している。

画面やコンポーネントに対応した、小さいhandlerがたくさんある。
serviceよりも細かい単位で区切られる（ことが多いと思われる）。

例: NoteShowHandler, NoteEditHandler <-> NoteService

依存: domain/services に依存する。infraを直接使うことはない。

### helpers

UIに関する処理を行うが、UIパーツではないもの。

日付のフォーマット、数値の変換など。

依存: 他のモジュールには依存しない。

## domain

ビジネスロジックを置いておくところ。

### models

ドメインにおけるデータをモデリングしたクラスを定義する。

ビジネスロジックは持たない、単なるデータクラス。

依存: 他のモジュールに依存しない。

### services

ドメインにおけるビジネスロジックを記述する。

infraの各モジュールを利用し、リモートやローカルやデバイスを操作する。

依存: infraを使う。

## infra

サーバAPIとの通信、デバイス機能の利用など、Serviceから利用されるモジュール郡。

リポジトリ層でもある。

依存: models以外のモジュールには依存しない。

# 実装例

## 状態管理

### ValueNotifier, ChangeNotifier

このサンプルアプリの状態管理について知る前に、その前段として
ValueNotifier, ChangeNotifier と
ValueListenableProvider, ChangeNotifierProvider を使う方法について。

```dart
ValueListenableProvider<int>(
  create: (BuildContext context) => ValueNotifier<int>(0),
  child: const YourCounterWidget(),
);
```

使う側は Provider.of もしくは Consumer で値を得る。

```dart
Consumer<int>(
  builder: (BuildContext context, int value, Widget child) {
    return Text('count is ${value}');
  },
);
```

```dart
final int value = Provider.of<int>(context, listen: true);
return Text('count is ${value}');
```

### SubjectProvider

本アプリでも、構造や内部の仕組みは、ValueNotifier, ChangeNotifier
と似たようなことを行っている。

ただし、別の箇所にあるWidgetが、同じ状態を参照するために、
store_builder というライブラリを使っている。



```dart
SubjectProvider<int>(
  initialValue: (BuildContext context) => 0,
  id: 'my counter',
  child: const YourCounterWidget(),
);
```

※consumeするほうは同じ

#### ValueNotifier

#### Redux

https://pub.dev/packages/flutter_redux

Reduxは状態を扱うStoreがアプリ内にひとつだけ存在する。
このため、状態の管理が中央で行われ、扱いやすい。

しかしながら、このStoreにはアプリ内のさまざまな状態が含まれる。

どれかを更新すると、すべての関連するWidgetの問い合わせの処理
（Storeから一部の状態を取り出してViewModelを作る）が実行される。

Widgetのrebuildではないが、不要な処理が実行されることになり、
アプリが大きくなったときのパフォーマンス上の懸念のため、採用しない。

※どの程度の影響があるか計測はしていない

## イベントハンドリング

Flutter には Notification というクラスがあり、
Widget ツリーをさかのぼってイベントを伝えることができる。

※プッシュ通知のことではなく、Flutter内の仕組み

例えば、スクロールできる Widget でスクロールすると
ScrollNotification が発行されており、
RefreshIndicator はこれを利用して実装されている。

ボタンなどで Notification を発行し、
NotificationListener で処理を行う。

```dart
NotificationListener<SomeNotification>(
  onNotification: (SomeNotification notification) {
    if (notification is SomeNotification) {
      // イベントに応じた処理
    }
    return true;
  },
  child: const YourChildWidget(),
);
```

`notification_handler` ライブラリを使う。

NotificationHandler で、子孫で発生した Notification を受け取り、
ハンドリングの状態を返す（provideされる）。

```dart
NotificationHandler<ArticleEvent, ArticleState>(
  initialState: const ArticleInital(),
  onEvent: (BuildContext context, ArticleEvent event) async* {
    final StoredSubject<Article> subject = subjectOf<Article>(context);
    if (event is ArticleStart) {
      yield const ArticleLoading();
      subject.value = await loadArticle();
      yield const ArticleSuccess();
    }
    
    ...
    
  },
  builder: builder,
  child: child,
);
```
