part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderIsLoading extends OrderState {}

class OrderIsSuccess extends OrderState {
  final String message;

  OrderIsSuccess(this.message);
}

class OrderIsFailed extends OrderState {
  final String message;

  OrderIsFailed(this.message);
}
