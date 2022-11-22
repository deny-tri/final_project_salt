part of 'screens.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<AddToChartCubit, AddToChartState>(
        listener: (context, state) {
          if (state is AddToChartIsSuccess) {
            Commons().showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return BlocBuilder<DetailProductsBloc, DetailProductsState>(
            builder: (context, detailState) {
              if (detailState is DetailProductsIsSuccess) {
                return ButtonWidget(
                  text: 'Add To Chart',
                  isLoading: (state is AddToChartIsLoading) ? true : false,
                  onPressed: () {
                    BlocProvider.of<AddToChartCubit>(context)
                        .addToChart(detailState.model);
                  },
                );
              }
              return Container();
            },
          );
        },
      ),
      body: SafeArea(
        child: BlocConsumer<DetailProductsBloc, DetailProductsState>(
          listener: (context, state) {
            if (state is DetailProductsIsFailed) {
              Commons().showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DetailProductsIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailProductsIsSuccess) {
              return DetailProductWidgets(data: state.model);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
        //  if (state is DetailProductsIsSuccess) {
        //     return VStack([
        //       AspectRatio(
        //         aspectRatio: 16 / 9,
        //         child: Image.network(state.model.picture!),
        //       ),
        //       state.model.name!.text.size(16).bold.make(),
        //       HStack([
        //         'Variant Produk'.text.make(),
        //         16.widthBox,
        //         HStack(state.model.category
        //             .map((e) =>
        //                 VxBox(child: e.text.color(colorName.white).make())
        //                     .color(colorName.grey)
        //                     .p4
        //                     .rounded
        //                     .make()
        //                     .pOnly(right: 4))
        //             .toList())
        //       ])
        //     ]);
        //   }