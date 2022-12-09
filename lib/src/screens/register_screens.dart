part of 'screens.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterIsFailed) {
                Commons().showSnackBar(context, state.message);
              } else if (state is RegisterIsSuccess) {
                context.go(routeName.home);
              }
            },
            child: VxBox(
              child: VStack(
                [
                  _buildHeaderText(),
                  _buildRegisterForm(),
                ],
                alignment: MainAxisAlignment.center,
                axisSize: MainAxisSize.max,
              ).p16(),
            )
                .gradientFromTo(
                    from: colorName.accentRed, to: colorName.accentYellow)
                .size(context.safePercentWidth * 100,
                    context.safePercentHeight * 100)
                .make(),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return VxBox(
      child: VStack(
        [
          'Created New Account'
              .text
              .bold
              .fontFamily('Poppins')
              .headline5(context)
              .color(colorName.white)
              .make(),
          'Enter your Email, Name and Password for sign up'
              .text
              .fontFamily('Poppins')
              .color(colorName.white)
              .make(),
          HStack([
            'for sign up. '
                .text
                .color(colorName.white)
                .fontFamily('Poppins')
                .make(),
            'Already Have Account'
                .text
                .bold
                .color(colorName.accentBlue)
                .fontFamily('Poppins')
                .make()
                .onTap(() {
              context.go(routeName.login);
            })
          ]),
        ],
      ),
    )
        .size(context.screenWidth, context.percentHeight * 20)
        .margin(const EdgeInsets.only(top: 20))
        .p16
        .make();
  }

  Widget _buildRegisterForm() {
    return VStack(
      [
        TextFieldWidget(
          title: "Email",
          controller: emailController,
        ),
        16.heightBox,
        TextFieldWidget(
          title: "Username",
          controller: usernameController,
        ),
        16.heightBox,
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        16.heightBox,
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<RegisterBloc>(context).add(
                  RegisterUser(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text),
                );
              },
              isLoading: (state is RegisterIsLoading) ? true : false,
              text: 'Register',
            );
          },
        ),
        8.heightBox,
        'Or Connect With'.text.fontFamily('Poppins').makeCentered(),
        IconButton(
          onPressed: () {
            BlocProvider.of<RegisterBloc>(context).add(GoogleSignInRequested());
          },
          icon: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
            height: 30,
            width: 30,
          ),
        ),
      ],
      crossAlignment: CrossAxisAlignment.center,
      axisSize: MainAxisSize.max,
    ).p(16).box.outerShadow.color(colorName.white).rounded.make();
  }
}
