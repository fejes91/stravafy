import 'dart:async';

// TODO this doesn't have a buffer must be replaced with shared pref or database
abstract class BaseHolder<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  Stream<T> get item => _controller.stream.asBroadcastStream();

  void setItem(T item) {
    _controller.add(item);
  }
}
