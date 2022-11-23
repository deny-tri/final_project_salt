part of 'list_cart_bloc.dart';

abstract class ListCartState {}

class ListCartInitial extends ListCartState {}

class ListCartIsLoading extends ListCartState {}

class ListCartIsSuccess extends ListCartState {
  final List<ProductModel> data;
  final List<ProductModel> retrainData;

  ListCartIsSuccess(this.data, this.retrainData);
}

class ListCartIsFailed extends ListCartState {
  final String message;

  ListCartIsFailed(this.message);
}
