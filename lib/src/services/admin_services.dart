part of 'services.dart';

class AdminService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, String>> addNewProduct(ProductModel data,
      {File? file}) async {
    try {
      productCollection.doc(data.id).set(data.toMap());
      if (file != null) {
        Reference ref = FirebaseStorage.instance.ref().child(data.id!);
        TaskSnapshot snapshot = await ref.putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          updateProduct(
            data.id!,
            data.copyWith(
                //  picture: downloadUrl,
                ),
          );
        }
      }
      return right('Berhasil Menambahkan Produk');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> updateProduct(
      String id, ProductModel data) async {
    try {
      productCollection.doc(data.id).update(data.toMap());
      return right('Berhasil Menambahkan Produk');
    } catch (e) {
      return left(e.toString());
    }
  }
}
