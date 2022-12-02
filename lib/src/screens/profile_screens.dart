part of 'screens.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Profile'
            .text
            .color(colorName.accentRed)
            .fontFamily('Poppins')
            .makeCentered(),
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
                                  .fontFamily('Poppins')
                                  .size(8)
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
                                            : null,
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
                                      .fontFamily('Poppins')
                                      .color(colorName.black)
                                      .size(16)
                                      .bold
                                      .make(),
                                  state.data.email!.text
                                      .fontFamily('Poppins')
                                      .color(colorName.black)
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
                                "https://www.pngitem.com/pimgs/m/421-4214640_clip-art-clothes-icon-clothing-icon-hd-png.png"),
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
                                "https://w7.pngwing.com/pngs/493/781/png-transparent-love-shape-public-interest-red-love.png"),
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
                        BlocProvider.of<UserBloc>(context).add(LogOutUser());
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
}
