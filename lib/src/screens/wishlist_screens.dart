part of 'screens.dart';

class WishListScreens extends StatelessWidget {
  const WishListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Favorite'
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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
        },
        child: SafeArea(
          child: BlocConsumer<ListWishlistBloc, ListWishlistState>(
            listener: (context, state) {
              if (state is ListWishlistIsFailed) {
                Commons().showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is ListWishlistIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ListWishlistIsSuccess && state.data.isNotEmpty) {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      VxDivider(color: colorName.grey.withOpacity(.2)).px16(),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final data = state.data[index];
                    return VxBox(
                      child: HStack(
                        [
                          VxBox()
                              .bgImage(DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    data.picture![0],
                                  )))
                              .roundedSM
                              .size(context.percentWidth * 16,
                                  context.percentWidth * 16)
                              .make(),
                          16.widthBox,
                          VStack(
                            [
                              data.name!.text.size(16).bold.make(),
                              4.heightBox,
                              Commons()
                                  .setPriceToIDR(data.price!)
                                  .text
                                  .size(12)
                                  .make(),
                            ],
                            alignment: MainAxisAlignment.start,
                          ).expand(),
                          BlocListener<WishlistCubit, WishlistState>(
                            listener: (context, state) {
                              if (state is WishlistIsSuccess) {
                                BlocProvider.of<ListWishlistBloc>(context)
                                    .add(FetchListWishlist());
                              }
                            },
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<WishlistCubit>(context)
                                    .removeFromWishList(data.id!);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: colorName.accentRed,
                              ),
                            ),
                          )
                        ],
                        alignment: MainAxisAlignment.start,
                      ).p16(),
                    ).make().onTap(() {
                      context.go(routeName.detailPath, extra: data.id);
                    });
                  },
                );
              }
              return VStack(
                [
                  "Favorites haven't been added yet"
                      .text
                      .fontFamily('Poppins')
                      .bodyText1(context)
                      .makeCentered(),
                  8.heightBox,
                  ButtonWidget(
                      color: colorName.accentRed,
                      text: 'Search Products',
                      onPressed: () {
                        context.go(routeName.productPath);
                      })
                ],
                crossAlignment: CrossAxisAlignment.center,
              ).centered();
            },
          ),
        ),
      ),
    );
  }
}
