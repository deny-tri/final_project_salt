part of 'widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final bool? isPassword;
  final bool? isEnabled;
  final int? maxLines;
  const TextFieldWidget(
      {super.key,
      this.controller,
      this.title,
      this.isPassword = false,
      this.isEnabled = true,
      this.maxLines = 1});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: colorName.black),
      enabled: widget.isEnabled!,
      textAlignVertical: TextAlignVertical.center,
      obscureText: (widget.isPassword!) ? isObscure : false,
      decoration: InputDecoration(
          // border: InputBorder.none,
          icon: (widget.isPassword!)
              ? const Icon(
                  Icons.lock,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
          hintText: widget.title,
          hintStyle: const TextStyle(
              fontSize: 14, color: colorName.black, fontFamily: 'Poppins'),
          suffixIcon: (widget.isPassword!)
              ? IconButton(
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  })
              : 0.heightBox),
    ).pSymmetric(h: 12).box.white.withRounded(value: 10).make();
  }
}

class TextAdmin extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;

  const TextAdmin({
    Key? key,
    this.controller,
    this.title,
  }) : super(key: key);

  @override
  State<TextAdmin> createState() => _TextAdminState();
}

class _TextAdminState extends State<TextAdmin> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: colorName.black),
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: const TextStyle(
            fontSize: 14, color: colorName.black, fontFamily: 'Poppins'),
      ),
    ).pSymmetric(h: 12).box.white.withRounded(value: 10).make();
  }
}
