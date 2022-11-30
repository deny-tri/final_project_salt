part of 'screens.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorName.white,
        iconTheme: const IconThemeData(color: colorName.black),
      ),
      bottomNavigationBar: BlocBuilder<DetailProductsBloc, DetailProductsState>(
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
                  builder: (context, categorytState) {
                    return ButtonWidget(
                      text: 'Add To Cart',
                      isLoading: (addToCartState is AddToCartIsLoading),
                      onPressed: () {
                        BlocProvider.of<AddToCartBloc>(context).add(AddToCart(
                            state.model,
                            (categorytState as CheckCategoryIsSelected)
                                .selectedCategory));
                      },
                    ).p16().box.white.withShadow([
                      BoxShadow(
                          blurRadius: 10, color: colorName.grey.withOpacity(.1))
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
          return Container();
        },
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
        'Deskripsi'.text.size(16).bold.make(),
        4.heightBox,
        state.model.description!.text.size(14).color(colorName.grey).make(),
      ]).py16(),
      VStack([
        'Category Produk'.text.bold.make(),
        8.heightBox,
        BlocBuilder<CheckCategoryCubit, CheckCategoryState>(
          builder: (context, categoryState) {
            return HStack(state.model.category!
                .map((e) => VxBox(
                            child: e.text
                                .color(
                                    (categoryState as CheckCategoryIsSelected)
                                            .selectedCategory
                                            .contains(e)
                                        ? colorName.white
                                        : colorName.black)
                                .make())
                        .color(categoryState.selectedCategory.contains(e)
                            ? colorName.secondary
                            : colorName.white)
                        .border(
                            color: categoryState.selectedCategory.contains(e)
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
        )
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
