// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_products_bloc.dart';

@immutable
abstract class DetailProductsState {}

class DetailProductsInitial extends DetailProductsState {}

class DetailProductsIsLoading extends DetailProductsState {}

class DetailProductsIsFailed extends DetailProductsState {
  final String message;
  DetailProductsIsFailed({
    required this.message,
  });
}

class DetailProductsIsSuccess extends DetailProductsState {
  final ProductModel model;
  DetailProductsIsSuccess({
    required this.model,
  });
}
