// ignore_for_file: unused_field

part of 'utilities.dart';

class Commons {
  final prefs = SharedPreferences.getInstance();
  final picker = ImagePicker();
  bool isLoading = false;

  void setUID(String uid) async {
    final storage = await prefs;
    await storage.setString(myUID, uid);
  }

  Future<String?> getUID() async {
    final storage = await prefs;
    return storage.getString(myUID);
  }

  Future<bool> removeUID() async {
    final storage = await prefs;
    return storage.remove(myUID);
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: message.text.make()));
  }

  Future<File> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    return File(pickedFile!.path);
  }

  Future<String> uploadFile(String id, File file, {String? fileName}) async {
    String imageName = fileName ??
        file.path.substring(
            file.path.lastIndexOf("/") + 1, file.path.lastIndexOf("."));
    Reference ref = FirebaseStorage.instance.ref('$id/$imageName');
    TaskSnapshot snapshot = await ref.putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  Future<List<String>> uploadFiles(String id, List<File> files) async {
    var imageUrls =
        await Future.wait(files.map((file) => uploadFile(id, file)));
    return imageUrls;
  }

  String setPriceToIDR(double price) {
    return NumberFormat.currency(locale: 'id_ID', decimalDigits: 0)
        .format(price)
        .toString();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      onPressed: () {
        BlocProvider.of<UserBloc>(context).add(LogOutUser());
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Log Out?",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
