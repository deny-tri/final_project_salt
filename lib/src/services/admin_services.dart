part of 'services.dart';

class AdminService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, String>> addNewProduct(ProductModel data,
      {List<File>? file}) async {
    try {
      productCollection.doc(data.id).set(data.toMap());
      if (file!.isNotEmpty) {
        final downloadUrls = await Commons().uploadFiles(data.id!, file);
        if (downloadUrls.isNotEmpty) {
          updateProduct(
            data.id!,
            data.copyWith(
              picture: downloadUrls,
            ),
          );
        }
      }
      return right('Product Added Successfully');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> updateProduct(
      String id, ProductModel data) async {
    try {
      productCollection.doc(data.id).update(data.toMap());
      return right('Product Added Successfully');
    } catch (e) {
      return left(e.toString());
    }
  }
}
