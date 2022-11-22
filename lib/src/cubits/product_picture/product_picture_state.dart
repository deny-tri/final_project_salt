// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_picture_cubit.dart';

@immutable
abstract class ProductPictureState {}

class ProductPictureInitial extends ProductPictureState {}

class ProductPictureIsLoaded extends ProductPictureState {
  final File file;
  ProductPictureIsLoaded({
    required this.file,
  });
}

class ProductPictureIsFailed extends ProductPictureState {}
