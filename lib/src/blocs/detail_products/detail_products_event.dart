// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_products_bloc.dart';

@immutable
abstract class DetailProductsEvent {}

class FetchDetailProduct extends DetailProductsEvent {
  final String docID;
  FetchDetailProduct({
    required this.docID,
  });
}
