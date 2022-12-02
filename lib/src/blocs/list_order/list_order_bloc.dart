import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  ListOrderBloc() : super(ListOrderInitial()) {
    on<FetchListOrder>((event, emit) async {
      emit(ListOrderIsLoading());
      final result = await OrderServices().fetchListOrder();
      emit(result.fold(
          (l) => ListOrderIsFailed(l), (r) => ListOrderIsSuccess(r)));
    });
  }
}
