part of 'screens.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserIsFailed) {
              Commons().showSnackBar(context, state.message);
            } else if (state is UserIsLogOut) {
              context.go(routeName.login);
            }
          },
          builder: (context, state) {
            if (state is UserIsLoading) {
              return const CircularProgressIndicator();
            } else if (state is UserIsSuccess) {
              return VStack(
                [
                  _buildAppbar(context, state.data),
                  24.heightBox,
                  _buildBannerHome(context),
                  24.heightBox,
                  _buildMenuHome(context),
                  24.heightBox,
                  'Promo'.text.bold.fontFamily('Poppins').make(),
                  8.heightBox,
                  VxBox(
                    child: _buildListProduct(),
                  )
                      .size(context.percentWidth * 100,
                          context.percentHeight * 20)
                      .make(),
                  8.heightBox,
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered().box.make(),
      ),
    );
  }

  Widget _buildBannerHome(BuildContext context) {
    return VxBox(
      child: Image.network(
        "https://assets.digination.id/crop/0x0:0x0/x/photo/2021/03/19/3776868825.png",
        fit: BoxFit.cover,
      ),
    )
        .size(context.safePercentWidth * 100, context.safePercentHeight * 20)
        .rounded
        .make();
  }

  Widget _buildMenuHome(BuildContext context) {
    return HStack(
      [
        VStack([
          IconButton(
            onPressed: () {
              context.go(routeName.productPath);
            },
            icon: const Icon(
              Icons.shopping_bag_rounded,
              color: colorName.accentRed,
            ),
          ),
          'Product'
              .text
              .bold
              .color(colorName.black)
              .fontFamily('Poppins')
              .makeCentered(),
        ]),
        VStack([
          IconButton(
            onPressed: () {
              context.go(routeName.wishlistPath);
            },
            icon: const Icon(
              Icons.favorite_border_rounded,
              color: colorName.accentRed,
            ),
          ),
          'Favorite'
              .text
              .bold
              .color(colorName.black)
              .fontFamily('Poppins')
              .makeCentered(),
        ]),
        VStack(
          [
            IconButton(
              onPressed: () {
                final cubit = context.read<DarkThemeCubit>();
                cubit.darkTheme();
              },
              icon: const Icon(
                Icons.dark_mode,
                color: colorName.accentRed,
              ),
            ),
            'Dark Theme'
                .text
                .bold
                .color(colorName.black)
                .fontFamily('Poppins')
                .makeCentered()
          ],
        )
      ],
      alignment: MainAxisAlignment.spaceBetween,
      axisSize: MainAxisSize.max,
    )
        .p16()
        .box
        .outerShadow
        .color(colorName.white)
        .size(context.safePercentWidth * 100, context.safePercentHeight * 15)
        .make();
  }

  Widget _buildAppbar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          HStack([
            VxCircle(
              radius: 56,
              backgroundImage: (data.photoProfile!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(data.photoProfile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ).onTap(() {
              context.go(routeName.profilePath);
            }),
            16.widthBox,
            'Good ${Commons().greeting()},\n'
                .richText
                .color(colorName.black)
                .size(12)
                .fontFamily('Poppins')
                .withTextSpanChildren([
              data.username!.textSpan.bold.size(18).make(),
            ]).make(),
          ]).expand(),
          BlocBuilder<CartCountCubit, CartCountState>(
            builder: (context, state) {
              return ZStack(
                [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CheckboxCartCubit>(context)
                          .removeAllCheckBox();
                      context.go(routeName.cartPath);
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: colorName.black,
                    ),
                  ),
                  (state as CartCountIsSuccess).value != 0
                      ? VxBox(
                              child: state.value.text
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
    ).gray100.make();
  }

  Widget _buildListProduct() {
    return BlocConsumer<ListProductBloc, ListProductState>(
      listener: (context, state) {
        if (state is ListProductIsFailed) {
          Commons().showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductIsLoading) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return const CircularProgressIndicator();
            },
          );
        }
        if (state is ListProductIsSuccess) {
          final data = state.products;
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 150.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProductHome(
                productHome: data[index],
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
