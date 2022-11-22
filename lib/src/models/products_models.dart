// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'models.dart';

class ProductModel {
  final String? id;
  final DateTime? dateTime;
  final String? name;
  final double? price;
  final String? picture;
  final String? description;
  final String? stock;
  final List<String> category;
  ProductModel({
    this.id,
    this.dateTime,
    this.name,
    this.price,
    this.picture,
    this.description,
    this.stock,
    required this.category,
  });
  // ProductModel({
  //   this.id,
  //   this.dateTime,
  //   this.name,
  //   this.price,
  //   this.picture,
  //   this.description,
  //   required this.category,
  // });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'dateTime': dateTime?.millisecondsSinceEpoch,
  //     'name': name,
  //     'price': price,
  //     'picture': picture,
  //     'description': description,
  //     'category': category,
  //   };
  // }

  // factory ProductModel.fromMap(Map<String, dynamic> map) {
  //   return ProductModel(
  //     id: map['id'] != null ? map['id'] as String : null,
  //     dateTime: map['dateTime'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
  //         : null,
  //     name: map['name'] != null ? map['name'] as String : null,
  //     price: map['price'] != null ? map['price'] as double : null,
  //     picture: map['picture'] != null
  //         ? map['picture'] as String
  //         : "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg",
  //     description:
  //         map['description'] != null ? map['description'] as String : null,
  //     category: map['category'] != null ? List.from(map['category']) : [],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProductModel.fromJson(String source) =>
  //     ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // ProductModel copyWith({
  //   String? id,
  //   DateTime? dateTime,
  //   String? name,
  //   double? price,
  //   String? picture,
  //   String? description,
  //   List<String>? category,
  // }) {
  //   return ProductModel(
  //     id: id ?? this.id,
  //     dateTime: dateTime ?? this.dateTime,
  //     name: name ?? this.name,
  //     price: price ?? this.price,
  //     picture: picture ?? this.picture,
  //     description: description ?? this.description,
  //     category: category ?? this.category,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'name': name,
      'price': price,
      'picture': picture,
      'description': description,
      'stock': stock,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      picture: map['picture'] != null
          ? map['picture'] as String
          : "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg",
      description:
          map['description'] != null ? map['description'] as String : null,
      stock: map['stock'] != null ? map['stock'] as String : null,
      category: map['category'] != null ? List.from(map['category']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductModel copyWith({
    String? id,
    DateTime? dateTime,
    String? name,
    double? price,
    String? picture,
    String? description,
    String? stock,
    List<String>? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      category: category ?? this.category,
    );
  }
}
