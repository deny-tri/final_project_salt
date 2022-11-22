// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:repticpedia/src/model/models.dart';
// import 'package:repticpedia/src/service/services.dart';

// part 'list_cart_event.dart';
// part 'list_cart_state.dart';

// class ListCartBloc extends Bloc<ListCartEvent, ListCartState> {
//   ListCartBloc() : super(ListCartInitial()) {
//     on<ListCartEvent>((event, emit) async {
//       emit(ListCartIsLoading());
//       final result = await ProductService().fetchListCart();
//       emit(result.fold((l) => ListCartIsFailed(l), (r) {
//         final data = <ProductModel>[];
//         data.addAll(r);
//         final retrainData = <ProductModel>[];
//         final dataFiltered = <String>{};
//         retrainData.retainWhere((x) => dataFiltered.add(x.category![0]));
//         return ListCartIsSuccess(data, retrainData);
//       }));
//     });
//     on<DecremenCart>((event, emit) async {
//       emit(ListCartIsLoading());
//       final result = await ProductService().removeCartItemCount(event.data);
//       result.fold((l) => emit(ListCartIsFailed(l)), (r) {
//         add(FetchListCart());
//       });
//     });
//   }
// }
