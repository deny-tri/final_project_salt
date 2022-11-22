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
                  //  _buildListProduct().expand(),
                  _buildMenuHome(context),
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered(),
      ),
    );
  }

  Widget _buildBannerHome(BuildContext context) {
    return const HStack([])
        .box
        .outerShadow
        .color(colorName.white)
        .size(context.safePercentWidth * 100, context.safePercentHeight * 15)
        .make();
  }

  Widget _buildMenuHome(BuildContext context) {
    return HStack(
      [
        VStack(
          [
            TextButton(
                onPressed: () {
                  context.go(routeName.profilePath);
                },
                child: 'profile'.text.make()),
            TextButton(
                onPressed: () {
                  context.go(routeName.productPath);
                },
                child: 'product'.text.make()),
          ],
        ),
      ],
      alignment: MainAxisAlignment.spaceBetween,
      axisSize: MainAxisSize.max,
    )
        .box
        .outerShadow
        .color(colorName.white)
        .size(context.safePercentWidth * 100, context.safePercentHeight * 20)
        .make();
  }

  Widget _buildAppbar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          HStack([
            VxCircle(
              radius: 80,
              backgroundImage: (data.photoProfile!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(data.photoProfile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ).onTap(() {
              context.go(routeName.adminPath);
            }),
            16.widthBox,
            '${Commons().greeting()},\n'
                .richText
                .size(12)
                .withTextSpanChildren([
              data.username!.textSpan.bold.size(18).make(),
            ]).make(),
          ]).expand(),
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    ).gray100.make();
  }

  // Widget _buildListProduct() {
  //   return BlocConsumer<ListProductBloc, ListProductState>(
  //     listener: (context, state) {
  //       if (state is ListProductIsFailed) {
  //         Commons().showSnackbar(context, state.message);
  //       }
  //     },
  //     builder: (context, state) {
  //       if (state is ListProductIsLoading) {
  //         return GridView.builder(
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 16,
  //             mainAxisSpacing: 16,
  //           ),
  //           itemBuilder: (context, index) {
  //             return Skelton();
  //           },
  //         );
  //       }
  //       if (state is ListProductIsSuccess) {
  //         final data = state.products;
  //         return GridView.builder(
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 16,
  //             mainAxisSpacing: 16,
  //           ),
  //           itemCount: data.length,
  //           itemBuilder: (context, index) {
  //             return ProductWidgets(
  //               products: data[index],
  //             );
  //           },
  //         );
  //       }

  //       return Container();
  //     },
  //   );
  // }
}
