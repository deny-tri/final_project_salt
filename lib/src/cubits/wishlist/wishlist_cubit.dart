// import 'package:bloc/bloc.dart';
// import 'package:repticpedia/src/cubit/check_saved/check_saved_cubit.dart';
// import 'package:repticpedia/src/model/models.dart';
// import 'package:repticpedia/src/service/services.dart';

// part 'wishlist_state.dart';

// class WishlistCubit extends Cubit<WishlistState> {
//   final CheckSavedCubit checkSavedCubit;
//   WishlistCubit(this.checkSavedCubit) : super(WishlistInitial());

//   void addToWishList(ProductModel model) async {
//     final result = await ProductService().addToWishList(model);
//     emit(result.fold((l) => WishlistIsFailed(l), (r) {
//       checkSavedCubit.checkWishList(model.id!);
//       return WishlistIsSuccess(r);
//     }));
//   }

//   void removeFromWishList(String id) async {
//     final result = await ProductService().removeFromWishList(id);
//     emit(result.fold((l) => WishlistIsFailed(l), (r) {
//       checkSavedCubit.checkWishList(id);
//       return WishlistIsSuccess(r);
//     }));
//   }
// }
