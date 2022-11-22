import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megashop/src/services/services.dart';

part 'cart_count_state.dart';

class CartCountCubit extends Cubit<CartCountState> {
  CartCountCubit() : super(CartCountIsSuccess(0));

  void getCartCount() async {
    final result = await ProductService().getCartItemCount();
    emit(
        result.fold((l) => CartCountIsFailed(l), (r) => CartCountIsSuccess(r)));
  }
}
