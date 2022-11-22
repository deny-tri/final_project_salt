part of 'check_category_cubit.dart';

abstract class CheckCategoryState {}

class CheckCategoryInitial extends CheckCategoryState {}

class CheckCategoryIsSelected extends CheckCategoryState {
  final String selectedCategory;

  CheckCategoryIsSelected(this.selectedCategory);
}
