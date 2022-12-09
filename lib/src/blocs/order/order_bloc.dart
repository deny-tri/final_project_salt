import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:final_project_salt/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderRequest>((event, emit) async {
      emit(OrderIsLoading());
      OrderModel orderModel = OrderModel(
          uid: await Commons().getUID(),
          dateTime: DateTime.now(),
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          paymentStatus: 0,
          productName: 'Shopping',
          totalPrice: event.totalPrice,
          products: event.products);
      final result = await OrderServices().orderProcess(orderModel);

      emit(result.fold((l) => OrderIsFailed(l), (r) => OrderIsSuccess(r)));
    });
  }
}
