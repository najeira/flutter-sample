import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:store_builder/store_builder.dart';

class AppEvent extends Notification {
  const AppEvent();
}

typedef AppStateWidgetBuilder<S> = Widget Function(
  BuildContext context,
  S state,
  Widget child,
);

abstract class AppEventHandler<E extends AppEvent, S> extends SingleChildStatefulWidget {
  const AppEventHandler({
    Key key,
    this.builder,
    Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final AppStateWidgetBuilder<S> builder;

  S get initialState;

  void onInit(BuildContext context) {
    
  }

  Stream<S> onEvent(BuildContext context, E event);

  StoredSubject<T> subjectOf<T>(BuildContext context) {
    return Provider.of<StoredSubject<T>>(context, listen: false);
  }

  T valueOf<T>(BuildContext context) {
    return subjectOf<T>(context).value;
  }

  @override
  _AppEventHandlerState<E, S> createState() {
    return _AppEventHandlerState<E, S>();
  }
}

/// eventを受け取ってeventのstreamに流す
/// eventをstateに変換するのは子の_AppEventHandlerInnerが行う
/// つまりこのwidgetはstateについては関知しない
class _AppEventHandlerState<E extends AppEvent, S> extends SingleChildState<AppEventHandler<E, S>> {
  final StreamController<E> _eventController = StreamController<E>.broadcast();

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    if (widget.builder != null) {
      child = Consumer<S>(
        builder: widget.builder,
        child: child,
      );
    }

    return NotificationListener<E>(
      child: _AppEventHandlerInner<E, S>(
        initialState: widget.initialState,
        onInit: widget.onInit,
        onEvent: widget.onEvent,
        eventStream: _eventController.stream,
        child: child,
      ),
      onNotification: (E event) {
        // _eventControllerに追加するとwidget.onEventへ渡る
        // _AppEventHandlerInner内StreamBuilder経由でrebuildされる
        _eventController.sink.add(event);

        // 上位のハンドラにはイベントを渡さない
        return true;
      },
    );
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}

class _AppEventHandlerInner<E extends AppEvent, S> extends SingleChildStatefulWidget {
  const _AppEventHandlerInner({
    Key key,
    this.initialState,
    @required this.onInit,
    @required this.onEvent,
    @required this.eventStream,
    Widget child,
  })  : assert(onEvent != null),
        assert(eventStream != null),
        super(
          key: key,
          child: child,
        );

  final S initialState;

  final void Function(BuildContext context) onInit;

  final Stream<S> Function(BuildContext context, E event) onEvent;

  final Stream<E> eventStream;

  @override
  _AppEventHandlerInnerState<E, S> createState() {
    return _AppEventHandlerInnerState<E, S>();
  }
}

/// eventをstateに変換してstateのstreamに流す
class _AppEventHandlerInnerState<E extends AppEvent, S> extends SingleChildState<_AppEventHandlerInner<E, S>> {
  BehaviorSubject<S> _stateController;
  StreamSubscription<S> _stateSubscription;

  bool _didInit = false;

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    if (!_didInit) {
      _didInit = true;

      if (widget.onInit != null) {
        widget.onInit(context);
      }
    }

    return StreamProvider<S>.value(
      value: _stateController.stream,
      child: child,
    );
  }

  @override
  void initState() {
    super.initState();
    _stateController = BehaviorSubject<S>.seeded(widget.initialState);
    _subscribe();
  }

  @override
  void didUpdateWidget(_AppEventHandlerInner<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.eventStream != oldWidget.eventStream) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    _stateController.close();
    super.dispose();
  }

  void _subscribe() {
    // Eを受け取ってSに変換する別のStreamを作る
    // Sが変わらないときにskipできるようにしたほうがいいかも？
    final Stream<S> stream = widget.eventStream.asyncExpand<S>(
      (E event) {
        return widget.onEvent(context, event);
      },
    );

    // 新しいイベントが来たらrebuildする
    // _stateControllerにaddするとStreamProvider経由で
    // childがrebuildされる
    _stateSubscription = stream.listen(
      (S state) {
        _stateController.sink.add(state);
      },
    );
  }

  void _unsubscribe() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
      _stateSubscription = null;
    }
  }
}
