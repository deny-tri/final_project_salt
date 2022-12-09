part of 'wishlist_count_cubit.dart';

@immutable
abstract class WishlistCountState {}

class WishlistCountInitial extends WishlistCountState {
  WishlistCountInitial(int i);
}

class WishlistCountIsSuccess extends WishlistCountState {
  final int value;

  WishlistCountIsSuccess(this.value);
}

class WishlistCountIsFailed extends WishlistCountState {
  final String message;

  WishlistCountIsFailed(this.message);
}
