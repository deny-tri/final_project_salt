// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AddProduct extends AdminEvent {
  final String? name;
  final String? description;
  final String? stock;
  final String? category;
  final double? price;
  AddProduct({
    this.name,
    this.description,
    this.stock,
    this.category,
    this.price,
  });
}
