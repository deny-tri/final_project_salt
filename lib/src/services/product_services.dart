part of 'services.dart';

class ProductService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);
  final usersCollection =
      FirebaseFirestore.instance.collection(userCollectionName);
  Future<Either<String, List<ProductModel>>> fetchListProduct() async {
    try {
      final querySnapshot = await productCollection.get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProductModel>> fetchDetailProduct(String docId) async {
    try {
      final documentSnapshot = await productCollection.doc(docId).get();

      final data = ProductModel.fromMap(documentSnapshot.data()!);
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListProductCaraKedua() async {
    try {
      final querySnapshot = await productCollection.get();

      final dataSatu = <ProductModel>[];
      for (var element in querySnapshot.docs) {
        dataSatu.add(ProductModel.fromMap(element.data()));
      }
      return right(dataSatu);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> addToCart(ProductModel model) async {
    try {
      String? uid = await Commons().getUID();
      final doc = await usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .add(model.toMap());

      await usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .doc(doc.id)
          .update(model.copyWith(id: doc.id).toMap());

      return right('Successfully Added to Cart');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> removeFromCart(
      List<ProductModel> models) async {
    try {
      String? uid = await Commons().getUID();

      for (var element in models) {
        await usersCollection
            .doc(uid)
            .collection(cartCollectionName)
            .doc(element.id)
            .delete();
      }

      return right('Successfully Added to Cart');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListCart() async {
    try {
      String? uid = await Commons().getUID();
      final querySnapshot =
          await usersCollection.doc(uid).collection(cartCollectionName).get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      data.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, int>> getWishlistItemCount() async {
    try {
      String? uid = await Commons().getUID();
      final querySnapshot = await usersCollection
          .doc(uid)
          .collection(wishListCollectionName)
          .get();
      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      final dataFiltered = <dynamic>{};
      data.retainWhere((x) => dataFiltered.add(x.type[0]));
      return right(dataFiltered.length);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, int>> getCartItemCount() async {
    try {
      String? uid = await Commons().getUID();
      final querySnapshot =
          await usersCollection.doc(uid).collection(cartCollectionName).get();
      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      final dataFiltered = <dynamic>{};
      data.retainWhere((x) => dataFiltered.add(x.category[0]));
      return right(dataFiltered.length);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> removeCartItemCount(ProductModel model) async {
    try {
      String? uid = await Commons().getUID();

      await usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .doc(model.id)
          .delete();

      return right('Deleted Successfully');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> addToWishlist(ProductModel model) async {
    try {
      String? uid = await Commons().getUID();
      usersCollection
          .doc(uid)
          .collection(wishListCollectionName)
          .doc(model.id)
          .set(model.toMap());

      return right('Saved Successfully');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> removeFromWishlist(String id) async {
    try {
      String? uid = await Commons().getUID();
      usersCollection
          .doc(uid)
          .collection(wishListCollectionName)
          .doc(id)
          .delete();

      return right('Successfully Removed from Favorites List');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, bool>> checkWishList(String id) async {
    try {
      String? uid = await Commons().getUID();
      final querySnapshot = await usersCollection
          .doc(uid)
          .collection(wishListCollectionName)
          .doc(id)
          .get();

      return right(querySnapshot.exists);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListWishlist() async {
    try {
      String? uid = await Commons().getUID();
      final querySnapshot = await usersCollection
          .doc(uid)
          .collection(wishListCollectionName)
          .get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> searchProduct() async {
    try {
      final querySnapshot = await productCollection.get();

      final searchData = <ProductModel>[];
      for (var element in querySnapshot.docs) {
        searchData.add(ProductModel.fromMap(element.data()));
      }
      return right(searchData);
    } catch (e) {
      return left(e.toString());
    }
  }
}
