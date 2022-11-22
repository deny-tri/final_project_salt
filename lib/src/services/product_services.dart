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
      String uid = await Commons().getUID();
      usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .doc(model.id)
          .set(model.toMap());

      return right('Berhasil Memasukkan Ke Keranjang');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListCart() async {
    try {
      String uid = await Commons().getUID();
      final querySnapshot =
          await usersCollection.doc(uid).collection(cartCollectionName).get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, int>> getCartItemCount() async {
    try {
      String uid = await Commons().getUID();
      final querySnapshot =
          await usersCollection.doc(uid).collection(cartCollectionName).get();

      return right(querySnapshot.docs.length);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> removeCartItemCount(String productID) async {
    try {
      String uid = await Commons().getUID();

      await usersCollection
          .doc(uid)
          .collection(cartCollectionName)
          .doc(productID)
          .delete();

      return right('Berhasil Dihapus');
    } catch (e) {
      return left(e.toString());
    }
  }
}

//Query Snapshot => banyak document

//Document Snapshot => satu document