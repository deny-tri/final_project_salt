// ignore_for_file: unused_field

part of 'services.dart';

class UserServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final usersCollection =
      FirebaseFirestore.instance.collection(userCollectionName);
  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? password, String? name}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final userData = UserModel(
          admin: false,
          email: userCredential.user!.email,
          photoProfile: '',
          uid: userCredential.user!.uid,
          username: name);

      usersCollection.doc(userCredential.user!.uid).set(userData.toMap());
      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<Either<String, UserModel>> loginWithEmail(
      {String? email, String? password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      return loadUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<Either<String, UserModel>> loadUserData(String? uid) async {
    try {
      final userData = await usersCollection.doc(uid).get();
      if (userData.data()!.isNotEmpty) {
        return right(UserModel.fromMap(userData.data()!));
      } else {
        return left('the user has not been registered');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split("]").last);
    }
  }

  Future<Either<String, UserModel>> changeProfile(UserModel userData) async {
    try {
      String? uid = await Commons().getUID();
      final newPhoto = await Commons().getImage();
      String downloadUrl =
          await Commons().uploadFile(uid!, newPhoto, fileName: uid);
      if (downloadUrl.isNotEmpty) {
        usersCollection
            .doc(uid)
            .set(userData.copyWith(photoProfile: downloadUrl).toMap());
      }
      return loadUserData(uid);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }

  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (result.user != null) {
        final userData = UserModel(
            admin: false,
            email: result.user!.email,
            photoProfile: '',
            uid: result.user!.uid,
            username: result.user!.email!.split('@')[0]);
        usersCollection.doc(result.user!.uid).set(userData.toMap());
        return right(userData);
      }
      return left('Login Failed');
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }

  Future<UserCredential> authGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
