part of 'screens.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: 'Profile'.text.color(colorName.accentRed).makeCentered(),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go(routeName.home);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: colorName.accentRed,
          ),
        ),
        elevation: 0,
        actions: [
          BlocBuilder<CartCountCubit, CartCountState>(
            builder: (context, state) {
              return ZStack(
                [
                  IconButton(
                    onPressed: () {
                      context.go(routeName.cartPath);
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: colorName.accentRed,
                    ),
                  ),
                  (state as CartCountIsSuccess).value != 0
                      ? VxBox(
                              child: state.value.text
                                  .size(8)
                                  .fontFamily('Poppins')
                                  .white
                                  .makeCentered()
                                  .p4())
                          .roundedFull
                          .color(colorName.accentRed)
                          .make()
                          .positioned(right: 8, top: 2)
                      : 0.heightBox
                ],
                alignment: Alignment.topRight,
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ZStack(
            [
              VxBox(
                child: ZStack(
                  [
                    VxBox()
                        .white
                        .size(context.safePercentWidth * 100,
                            context.percentHeight * 15)
                        .margin(
                          const EdgeInsets.only(top: 80),
                        )
                        .make(),
                    VxBox()
                        .size(context.safePercentWidth * 35,
                            context.safePercentHeight * 20)
                        .white
                        .roundedFull
                        .margin(
                          const EdgeInsets.only(bottom: 55),
                        )
                        .make(),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserIsSuccess) {
                          return VStack(
                            [
                              ZStack(
                                [
                                  VxCircle(
                                    radius: 120,
                                    backgroundImage:
                                        (state.data.photoProfile!.isNotEmpty)
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    state.data.photoProfile!),
                                                fit: BoxFit.cover,
                                              )
                                            : const DecorationImage(
                                                image: NetworkImage(
                                                    "https://perpustakaan.unej.ac.id/wp-content/uploads/2016/09/person-icon.png"),
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    color: colorName.white,
                                    icon: const Icon(Icons.photo_camera)
                                        .onTap(() {
                                      BlocProvider.of<UserBloc>(context)
                                          .add(ChangePhoto());
                                    }),
                                  )
                                ],
                                alignment: Alignment.center,
                              ),
                              16.heightBox,
                              VStack(
                                [
                                  state.data.username!.text
                                      .color(colorName.black)
                                      .fontFamily('Poppins')
                                      .size(16)
                                      .bold
                                      .make(),
                                  state.data.email!.text
                                      .color(colorName.black)
                                      .fontFamily('Poppins')
                                      .size(12)
                                      .make(),
                                ],
                                crossAlignment: CrossAxisAlignment.center,
                              ),
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ).wFull(context);
                        }
                        return 0.heightBox;
                      },
                    ),
                  ],
                  alignment: Alignment.center,
                ).p20(),
              )
                  .size(context.safePercentWidth * 100,
                      context.percentHeight * 38)
                  .color(colorName.accentRed)
                  .make(),
              VxBox(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.historiPath);
                      },
                      child: Card(
                        child: ListTile(
                          title: 'Histori'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.wallet,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.productPath);
                      },
                      child: Card(
                        child: ListTile(
                          title: 'Product'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.shopping_bag,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.cartPath);
                      },
                      child: Card(
                        child: ListTile(
                          title: 'My Cart'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.shopping_cart,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.wishlistPath);
                      },
                      child: Card(
                        child: ListTile(
                          title: 'Wish List'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.favorite,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final cubit = context.read<DarkThemeCubit>();
                        cubit.darkTheme();
                      },
                      child: Card(
                        child: ListTile(
                          title: 'Dark Mode'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.dark_mode,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                        //   BlocProvider.of<UserBloc>(context).add(LogOutUser());
                      },
                      child: Card(
                        child: ListTile(
                          title: 'Log Out'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundColor: colorName.accentRed,
                            child: Icon(
                              Icons.logout,
                              color: colorName.white,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  .outerShadow
                  .white
                  .rounded
                  .size(
                      context.safePercentWidth * 90, context.percentHeight * 50)
                  .margin(
                    const EdgeInsets.only(top: 280),
                  )
                  .makeCentered(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Tidak",
        style: TextStyle(fontFamily: 'Poppins'),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Ya",
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
