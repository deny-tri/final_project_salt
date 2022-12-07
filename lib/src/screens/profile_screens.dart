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
                                    backgroundImage: (user.photoURL!.isNotEmpty)
                                        ? DecorationImage(
                                            image: NetworkImage(user.photoURL!),
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png"),
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
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/272/272889.png"),
                          ),
                          trailing: const Icon(Icons.star),
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
                            backgroundImage: NetworkImage(
                                "https://www.pngitem.com/pimgs/m/421-4214640_clip-art-clothes-icon-clothing-icon-hd-png.png"),
                          ),
                          trailing: const Icon(Icons.star),
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
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSXmOP50sxAPhk-F9YpM1HgkB9g9-C9Z9VRQ&usqp=CAU"),
                          ),
                          trailing: const Icon(Icons.star),
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
                            backgroundImage: NetworkImage(
                                "https://p.kindpng.com/picc/s/82-828436_red-heart-icon2x-environmental-defence-canada-hd-png.png"),
                          ),
                          trailing: const Icon(Icons.star),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(routeName.adminPath);
                      },
                      child: Card(
                        child: ListTile(
                          title:
                              'Add Product'.text.fontFamily('Poppins').make(),
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/3523/3523887.png"),
                          ),
                          trailing: const Icon(Icons.star),
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
                            backgroundImage: NetworkImage(
                                "https://png.pngtree.com/png-clipart/20190520/original/pngtree-vector-logout-icon-png-image_4276345.jpg"),
                          ),
                          trailing: const Icon(Icons.star),
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
