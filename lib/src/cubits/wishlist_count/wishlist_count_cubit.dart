import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_count_state.dart';

class WishlistCountCubit extends Cubit<WishlistCountState> {
  WishlistCountCubit() : super(WishlistCountIsSuccess(0));
  void getWishlistCount() async {
    final result = await ProductService().getWishlistItemCount();
    emit(result.fold(
        (l) => WishlistCountIsFailed(l), (r) => WishlistCountIsSuccess(r)));
  }
}
