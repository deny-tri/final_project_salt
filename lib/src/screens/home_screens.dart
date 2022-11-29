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
                  'Promo'.text.bold.make(),
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
        VStack(
          [
            IconButton(
              onPressed: () {
                context.go(routeName.profilePath);
              },
              icon: const Icon(
                Icons.person,
                color: colorName.accentRed,
              ),
            ),
            'Profile'.text.bold.color(colorName.black).makeCentered()
          ],
        ).p16(),
        VStack(
          [
            IconButton(
              onPressed: () {
                context.go(routeName.productPath);
              },
              icon: const Icon(
                Icons.shopping_bag_rounded,
                color: colorName.accentRed,
              ),
            ),
            'Product'.text.bold.color(colorName.black).makeCentered()
          ],
        ).p16(),
        VStack(
          [
            IconButton(
              onPressed: () {
                context.go(routeName.cartPath);
              },
              icon: const Icon(
                Icons.shopping_cart_rounded,
                color: colorName.accentRed,
              ),
            ),
            'My Cart'.text.bold.color(colorName.black).makeCentered()
          ],
        ).p16(),
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
            'Dark Theme'.text.bold.color(colorName.black).makeCentered()
          ],
        ).p16(),
      ],
      alignment: MainAxisAlignment.spaceBetween,
      axisSize: MainAxisSize.max,
    )
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
            16.widthBox,
            'Good ${Commons().greeting()},\n'
                .richText
                .color(colorName.black)
                .size(12)
                .withTextSpanChildren([
              data.username!.textSpan.bold.size(18).make(),
            ]).make(),
          ]).expand(),
          IconButton(
            onPressed: () {
              // BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(
              Icons.search,
              color: colorName.black,
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: colorName.black,
            ),
          ),
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
          // return ListView.builder(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   itemCount: data.length,
          //   itemBuilder: (context, index) =>
          //       ProductHome(productHome: data[index]),
          // );
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 150.0,
            ),
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 16,
            //   scrollDirection: Axis.horizontal,
            //   mainAxisSpacing: 16,

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
