import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddToCart>((event, emit) async {
      emit(AddToCartIsLoading());
      final selectedVariant = <String>[];

      if (event.data.category.isNotEmpty) {
        if (event.selectedCategory.isNotEmpty) {
          selectedVariant.add(event.selectedCategory);
          final result = await ProductService().addToCart(event.data.copyWith(
            category: selectedVariant,
          ));
          emit(result.fold(
              (l) => AddToCartIsFailed(l), (r) => AddToCartIsSuccess(r)));
        } else {
          emit(AddToCartIsFailed('Silahkan pilih Category'));
        }
      } else {
        final result = await ProductService().addToCart(event.data);
        emit(result.fold(
            (l) => AddToCartIsFailed(l), (r) => AddToCartIsSuccess(r)));
      }
    });
  }
}
