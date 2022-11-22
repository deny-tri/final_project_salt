
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:repticpedia/src/service/services.dart';

// part 'check_saved_state.dart';

// class CheckSavedCubit extends Cubit<CheckSavedState> {
//   CheckSavedCubit() : super(CheckSavedInitial());
//   void checkWishList(String id) async {
//     final result = await ProductService().checkWishList(id);
//     emit(result.fold((l) => CheckSavedIFailed(),
//         (r) => (r) ? CheckSavedIsSuccess() : CheckSavedIFailed()));
//   }
// }
