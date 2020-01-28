# flutter_sample

Flutterでアプリを作るアーキテクチャの一例

# ディレクトリ構造

- app
  - pages
  - widgets
  - blocs
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

Flutterでは画面とパーツに大きな違いはないが、人間の認識では違うものなので、なんとなく分けておく。

依存: blocsとhelpersに依存する。domainやinfraを直接使うことはない。

### blocs

UIからの入力を受け付ける。

Widgetではなく、アプリケーションのロジックを書く場所。

アプリの状態を知っており、必要に応じてServiceに処理をさせる。状態とイベントを合成することで、Serviceへの入力になる。

Store内のデータを監視しており、状態が変わったらUIへ更新を伝える。これはBlocが自分自身へイベントをaddすることで行われる。

画面やコンポーネントに対応した、小さいBlocがたくさんある。Serviceよりも細かい単位で区切られる（ことが多いと思われる）。

例: NoteShowBloc, NoteEditBloc <-> NoteService

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

## Bloc

blocおよびflutter_blocを利用する。

```dart
class NoteShowBloc extends Bloc<NoteEvent, NoteState> {
  NoteShowBloc(Note note)
    : initialState = NoteInitial(note: note),
      // 型とIDで、Store内のデータのSubjectを得る
      _noteSubject = getIt<Store>().use<Note>(note.id),
      // 更新を受け取るためのコールバックを設定する
      _noteSubscription = _noteSubject.listen(_onData),
      super();

  @override
  final NoteState initialState;

  // Storeに更新を伝えるためのSubject
  final StoreSubject<Note> _noteSubject;

  // Storeの更新を知るための購読
  final StreamSubscription<Note> _noteSubscription;

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is NoteLiked) {
      // ここで処理中という状態にしておくことで
      // UI側でボタン等をdisableや処理中の表示にできる
      yield NoteLikeProgress(state);

      // ビジネスロジックはServiceに実装し、処理を委譲する
      final NoteService svc = getIt<NoteService>();
      try {
        await svc.noteLikeAdd(state.note.id);
      } catch (Object error) {
        yield NoteLikeFailure(state, error);
        return;
      }

      // stateが保持しているデータを直接書き換えていいだろうか？
      // コピーを作成してから更新したほうがいいだろうか？
      state.note.isLiked = true;

      // 他のBlocにも更新を伝えるためにStoreから得たsubjectを更新する
      _noteSubject.add(state.note);

      // subjectを更新するとコールバック側で状態が変更されるため
      // ここでは状態を変更しない

    } else if (event is NoteUpdated) {
      yield NoteUpdateSuccess(note: event.note);
    }
  }

  void _onData(Note note) {
    // データの更新をイベントとして自分自身へ伝える
    add(NoteUpdated(note));
  }

  @override
  Future<void> close() async {
    _noteSubscription?.cancel();
    _noteSubject?.release();
    super.close();
  }
}
```

### BlocState

```dart
abstract class NoteState {
  NoteState({this.note});

  NoteState.copy(NoteState state) : this(note: state?.note);

  final Note note;
}

class NoteInitial extends NoteState {
  NoteUpdateSuccess(Note note) : super(note: note);
}

class NoteLikeProgress extends NoteState {
  NoteLikeProgress(NoteState state) : super.copy(state);
}

class NoteLikeFailure extends NoteState {
  NoteLikeProgress(NoteState state, this.error) : super.copy(state);

  Object error;
}

class NoteUpdateSuccess extends NoteState {
  NoteUpdateSuccess({Note note}) : super(note: note);
}
```

### BlocEvent

```dart
abstract class NoteEvent {
}

// 対象データはBlocが持っており、イベントには持たない
class NoteLiked extends NoteEvent {
}

class NoteUpdated extends NoteEvent {
  NoteTitleEdited(this.note);

  final Note note;
}

// Blocにないデータがある場合だけイベントはパラメータを持たせる
class NoteTitleEdited extends NoteEvent {
  NoteTitleEdited(this.title);

  final String title;
}
```

###  BlocListener

同じBlocを使っていても、UIへの表出が異なる場合がある。

例えば、詳細画面で削除されたら「画面を閉じる」で、一覧画面で削除されたら「削除済み表示にする」など。

BlocにはUIから離れたビジネスロジックだけを記述することになるため、ローディング表示、ダイアログ表示、画面遷移などはWidget側で行うことになる。

BlocListenerを使って、Blocの状態を得ることができるので、状態の変化に応じた処理を記述する。

```dart
class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc, NoteState>(
      create: (_) => NoteShowBloc(note),
      child: BlocListener(
        child: const NoteDetailView(),
        listen: (BuildContext context, NoteState state) {
          if (state is NoteDeleteProgress) {
            showProgressDialog(context);
          } else {
            closeProgressDialog(context);
          }

          if (state is NoteDeleteSuccess) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
```

## Store

上記のBlocでStoreというクラスを使っている。

BlocはUIコンポーネントに対応して作成されており、Blocが持つのはアプリの状態のうち一部（Bloc自身が関連するものだけ）となる。

アプリには複数のBlocが存在し、それぞれが同じデータを参照する場合がある。そのため、Blocより上位の、アプリの状態の全体を管理する必要があり、それをStoreというクラスを使って実現する。

実証はしていないが https://github.com/najeira/flutter-store-builder をそのために開発中なので、これが使えるはず（単にメモリ上にMapで持っているのを、少し機能拡張している）。

`getIt` は  get_it (https://pub.dev/packages/get_it) をラップしたもの。

```dart
T getIt<T>([String name]) {
  return GetIt.instance.get<T>(name);
}
```

## その他

pages, widgets はだいたい変わらないし、 models, services, infra あたりは、アプリによるし、とくに例示なし。

# まとめ
