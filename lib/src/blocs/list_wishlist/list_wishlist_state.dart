// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_wishlist_bloc.dart';

@immutable
abstract class ListWishlistState {}

class ListWishlistInitial extends ListWishlistState {}

class ListWishlistIsLoading extends ListWishlistState {}

class ListWishlistIsSuccess extends ListWishlistState {
  final List<ProductModel> data;
  ListWishlistIsSuccess({
    required this.data,
  });
}

class ListWishlistIsFailed extends ListWishlistState {
  final String message;
  ListWishlistIsFailed({
    required this.message,
  });
}
