import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_category_state.dart';

class CheckCategoryCubit extends Cubit<CheckCategoryState> {
  CheckCategoryCubit() : super(CheckCategoryIsSelected(''));

  void selectedItem(String newString) {
    String listData = (state as CheckCategoryIsSelected).selectedCategory;
    if (!listData.contains(newString)) {
      listData = newString;
    } else {
      listData = '';
    }
    emit(CheckCategoryIsSelected(listData));
  }
}
