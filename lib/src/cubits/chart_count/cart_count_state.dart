part of 'cart_count_cubit.dart';

abstract class CartCountState {}

class CartCountInitial extends CartCountState {
  CartCountInitial(int i);
}

class CartCountIsSuccess extends CartCountState {
  final int value;

  CartCountIsSuccess(this.value);
}

class CartCountIsFailed extends CartCountState {
  final String message;

  CartCountIsFailed(this.message);
}
