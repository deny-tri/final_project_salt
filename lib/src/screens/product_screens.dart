part of 'screens.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Product'.text.make(),
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

            return Container();
          },
        ),
      ),
    );
  }
}
