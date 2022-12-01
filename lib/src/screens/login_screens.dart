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
                    "assets/images/logo.jpeg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                16.heightBox,
                _buildLoginForm(),
              ],
              alignment: MainAxisAlignment.center,
              axisSize: MainAxisSize.max,
            ).p16(),
          ).gradientFromTo(from: Vx.red400, to: Vx.blue400).make(),
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
        'Forget Password?'.text.color(colorName.accentBlue).make(),
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
            'Create new account?'.text.makeCentered(),
            8.widthBox,
            'Register'
                .text
                .color(colorName.accentBlue)
                .makeCentered()
                .onTap(() {
              context.go(routeName.register);
            }),
          ],
          alignment: MainAxisAlignment.center,
          axisSize: MainAxisSize.max,
        ),
        8.heightBox,
        'Or Continue With'.text.bold.makeCentered(),
        8.heightBox,
        IconButton(
          onPressed: () {
            // _authenticateWithGoogle(context);
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
