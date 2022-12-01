part of 'list_cart_bloc.dart';

@immutable
abstract class ListCartEvent {}

class FetchListCart extends ListCartEvent {}

class DecrementCart extends ListCartEvent {
  final ProductModel data;

  DecrementCart(this.data);
}

class RemoveCartAfterOrder extends ListCartEvent {
  final List<ProductModel> models;

  RemoveCartAfterOrder(this.models);
}
