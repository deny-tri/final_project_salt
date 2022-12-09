part of 'screens.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Products'
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
        body: SafeArea(
          child: BlocConsumer<ListProductBloc, ListProductState>(
            listener: (context, state) {
              if (state is ListProductIsFailed) {
                Commons().showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is ListProductIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ListProductIsSuccess) {
                final data = state.products;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ProductWidgets(
                      products: data[index],
                    );
                  },
                );
              }

              return 0.heightBox;
            },
          ),
        ),
      ),
    );
  }
}
