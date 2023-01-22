import 'dart:async';

abstract class BaseHolder<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  Stream<T> get item => _controller.stream;

  void setItem(T item) {
    _controller.add(item);
  }
}
