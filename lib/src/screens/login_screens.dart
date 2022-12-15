part of 'screens.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.accentBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginIsFailed) {
                Commons().showSnackBar(context, state.message);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: state.message.text.make()));
              } else if (state is LoginIsSuccess) {
                context.go(routeName.home);
              }
            },
            child: VxBox(
              child: VStack(
                [
                  Center(
                    child: Image.asset(
                      "assets/images/logomegashop.png",
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  _buildLoginForm(),
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

  Widget _buildLoginForm() {
    return VStack(
      [
        TextFieldWidget(
          title: "Email",
          controller: emailController,
        ),
        16.heightBox,
        TextFieldWidget(
          title: "Password",
          controller: passwordController,
          isEnabled: true,
          isPassword: true,
        ),
        8.heightBox,
        16.heightBox,
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginUser(
                      email: emailController.text,
                      password: passwordController.text),
                );
              },
              isLoading: (state is LoginIsLoading) ? true : false,
              text: 'Login',
            );
          },
        ),
        HStack(
          [
            'Create new account?'
                .text
                .color(colorName.black)
                .fontFamily('Poppins')
                .makeCentered(),
            8.widthBox,
            'Register'
                .text
                .color(colorName.accentBlue)
                .fontFamily('Poppins')
                .makeCentered()
                .onTap(() {
              context.go(routeName.register);
            }),
          ],
          alignment: MainAxisAlignment.center,
          axisSize: MainAxisSize.max,
        ),
        8.heightBox,
        'Or Continue With'
            .text
            .bold
            .color(colorName.black)
            .fontFamily('Poppins')
            .makeCentered(),
        8.heightBox,
        IconButton(
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(GoogleLoginInRequested());
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
    ).p(16).box.outerShadow.rounded.color(colorName.white).make();
  }
}
