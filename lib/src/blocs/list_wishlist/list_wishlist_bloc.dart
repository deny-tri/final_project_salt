import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_wishlist_event.dart';
part 'list_wishlist_state.dart';

class ListWishlistBloc extends Bloc<ListWishlistEvent, ListWishlistState> {
  ListWishlistBloc() : super(ListWishlistInitial()) {
    on<FetchListWishlist>((event, emit) async {
      emit(ListWishlistIsLoading());
      final result = await ProductService().fetchListWishlist();

      emit(result.fold((l) => ListWishlistIsFailed(message: l),
          (r) => ListWishlistIsSuccess(data: r)));
    });
  }
}
