part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent {}

class AddToCart extends AddToCartEvent {
  final ProductModel data;
  final String selectedCategory;

  AddToCart(this.data, this.selectedCategory);
}
