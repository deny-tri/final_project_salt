import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megashop/src/models/models.dart';
import 'package:megashop/src/services/services.dart';

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
        final dataFiltered = <String>{}; //variabel penampung untuk hasil filter
        retrainData.retainWhere((x) => dataFiltered.add(x.category![0]));
        //mengahpus data yang kembar
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
  }
}
