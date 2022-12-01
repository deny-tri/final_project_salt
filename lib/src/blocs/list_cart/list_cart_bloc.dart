import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_cart_event.dart';
part 'list_cart_state.dart';

class ListCartBloc extends Bloc<ListCartEvent, ListCartState> {
  ListCartBloc() : super(ListCartInitial()) {
    on<FetchListCart>((event, emit) async {
      emit(ListCartIsLoading());
      final result = await ProductService().fetchListCart();

      emit(result.fold((l) => ListCartIsFailed(l), (r) {
        final data = <ProductModel>[];
        data.addAll(r);
        final retrainData = <ProductModel>[];
        retrainData.addAll(r);
        final dataFiltered = <String>{};
        retrainData.retainWhere((x) => dataFiltered.add(x.category[0]));
        return ListCartIsSuccess(data, retrainData);
      }));
    });
    on<DecrementCart>((event, emit) async {
      emit(ListCartIsLoading());
      final result = await ProductService().removeCartItemCount(event.data);
      result.fold((l) => emit(ListCartIsFailed(l)), (r) {
        add(FetchListCart());
      });
    });
    on<RemoveCartAfterOrder>((event, emit) async {
      emit(ListCartIsLoading());
      final result = await ProductService().removeFromCart(event.models);
      result.fold((l) => emit(ListCartIsFailed(l)), (r) {
        add(FetchListCart());
      });
    });
  }
}
