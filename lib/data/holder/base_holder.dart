import 'dart:async';
import 'package:rxdart/rxdart.dart';

abstract class BaseHolder<T> {
  final BehaviorSubject<T> _holder = BehaviorSubject<T>();

  Stream<T> get item => _holder;

  void setItem(T item) {
    _holder.value = item;
  }
}
