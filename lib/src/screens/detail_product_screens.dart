part of 'screens.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Detail Product'
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
        bottomNavigationBar:
            BlocBuilder<DetailProductsBloc, DetailProductsState>(
          builder: (context, state) {
            if (state is DetailProductsIsSuccess) {
              return BlocConsumer<AddToCartBloc, AddToCartState>(
                listener: (context, addToCartState) {
                  if (addToCartState is AddToCartIsSuccess) {
                    Commons().showSnackBar(context, addToCartState.message);
                  }
                  if (addToCartState is AddToCartIsFailed) {
                    Commons().showSnackBar(context, addToCartState.message);
                  }
                },
                builder: (context, addToCartState) {
                  return BlocBuilder<CheckCategoryCubit, CheckCategoryState>(
                    builder: (context, categoryState) {
                      return ButtonWidget(
                        text: 'Add To Cart',
                        isLoading: (addToCartState is AddToCartIsLoading),
                        onPressed: () {
                          BlocProvider.of<AddToCartBloc>(context).add(AddToCart(
                              state.model,
                              (categoryState as CheckCategoryIsSelected)
                                  .selectedCategory));
                        },
                      ).p16().box.white.withShadow([
                        BoxShadow(
                            blurRadius: 10,
                            color: colorName.grey.withOpacity(.1))
                      ]).make();
                    },
                  );
                },
              );
            }
            return 0.heightBox;
          },
        ),
        body: BlocBuilder<DetailProductsBloc, DetailProductsState>(
          builder: (context, state) {
            if (state is DetailProductsIsSuccess) {
              return VStack([
                _buildListImage(state),
                _buildProductDetails(state),
              ]).scrollVertical();
            }
            return 0.heightBox;
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(DetailProductsIsSuccess state) {
    return VStack([
      HStack([
        VStack([
          state.model.name!.text.size(20).semiBold.make(),
          8.heightBox,
          Commons().setPriceToIDR(state.model.price!).text.size(16).make(),
        ]).expand(),
        BlocListener<WishlistCubit, WishlistState>(
          listener: (context, wishlistState) {
            if (wishlistState is WishlistIsSuccess) {
              Commons().showSnackBar(context, wishlistState.message);
            }
            if (wishlistState is WishlistIsFailed) {
              Commons().showSnackBar(context, wishlistState.message);
            }
          },
          child: BlocBuilder<CheckSavedCubit, CheckSavedState>(
            builder: (context, checkSavedState) {
              if (checkSavedState is CheckSavedIsSuccess) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<WishlistCubit>(context)
                          .removeFromWishList(state.model.id!);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: colorName.accentRed,
                    ));
              }
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<WishlistCubit>(context)
                        .addToWishList(state.model);
                  },
                  icon: const Icon(Icons.favorite_border_rounded));
            },
          ),
        )
      ]),
      VStack([
        'Deskripsi'.text.size(16).bold.fontFamily('Poppins').make(),
        4.heightBox,
        state.model.description!.text
            .size(14)
            .fontFamily('Poppins')
            .color(colorName.grey)
            .make(),
      ]).py16(),
      VStack([
        'Category'.text.size(16).bold.fontFamily('Poppins').make(),
        4.heightBox,
        HStack(state.model.category
            .map((e) => VxBox(
                    child: e.text
                        .fontFamily('Poppins')
                        .color(colorName.white)
                        .make())
                .color(colorName.grey)
                .p4
                .rounded
                .make()
                .pOnly(right: 4))
            .toList()),
      ]).py16(),
      VStack([
        'Type Produk'.text.bold.fontFamily('Poppins').make(),
        8.heightBox,
        BlocBuilder<CheckCategoryCubit, CheckCategoryState>(
          builder: (context, typeState) {
            return HStack(state.model.type
                .map((e) => VxBox(
                            child: e.text
                                .fontFamily('Poppins')
                                .color((typeState as CheckCategoryIsSelected)
                                        .selectedCategory
                                        .contains(e)
                                    ? colorName.white
                                    : colorName.black)
                                .make())
                        .color(typeState.selectedCategory.contains(e)
                            ? colorName.secondary
                            : colorName.white)
                        .border(
                            color: typeState.selectedCategory.contains(e)
                                ? colorName.white
                                : colorName.grey)
                        .p16
                        .rounded
                        .make()
                        .onTap(() {
                      BlocProvider.of<CheckCategoryCubit>(context)
                          .selectedItem(e);
                    }).pOnly(right: 4))
                .toList());
          },
        ),
        VStack([
          'Stock Items'.text.size(16).bold.fontFamily('Poppins').make(),
          4.heightBox,
          state.model.stock!.text
              .size(14)
              .fontFamily('Poppins')
              .color(colorName.grey)
              .make(),
        ]).py16(),
      ])
    ]).p16();
  }

  Widget _buildListImage(DetailProductsIsSuccess state) {
    return VxSwiper.builder(
      itemCount: state.model.picture!.length,
      autoPlay: true,
      aspectRatio: 16 / 9,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            state.model.picture![index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
