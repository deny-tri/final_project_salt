import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megashop/src/models/models.dart';
import 'package:megashop/src/services/services.dart';

part 'add_to_chart_state.dart';

class AddToChartCubit extends Cubit<AddToChartState> {
  AddToChartCubit() : super(AddToChartInitial());
  void addToChart(ProductModel model) async {
    emit(AddToChartIsLoading());
    final result = await ProductService().addToCart(model);
    emit(result.fold((l) => AddToChartIsFailed(message: l),
        (r) => AddToChartIsSuccess(message: r)));
  }
}
