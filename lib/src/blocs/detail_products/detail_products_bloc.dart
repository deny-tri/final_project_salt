import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megashop/src/models/models.dart';
import 'package:megashop/src/services/services.dart';

part 'detail_products_event.dart';
part 'detail_products_state.dart';

class DetailProductsBloc
    extends Bloc<DetailProductsEvent, DetailProductsState> {
  DetailProductsBloc() : super(DetailProductsInitial()) {
    on<FetchDetailProduct>((event, emit) async {
      emit(DetailProductsIsLoading());
      final result = await ProductService().fetchDetailProduct(event.docID);
      emit(result.fold((l) => DetailProductsIsFailed(message: l),
          (r) => DetailProductsIsSuccess(model: r)));
    });
  }
}
