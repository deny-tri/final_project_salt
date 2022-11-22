part of 'screens.dart';

class AdminScreens extends StatefulWidget {
  const AdminScreens({super.key});

  @override
  State<AdminScreens> createState() => _AdminScreensState();
}

class _AdminScreensState extends State<AdminScreens> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController productStockController = TextEditingController();
  void reset() {
    productNameController.clear();
    productPriceController.clear();
    BlocProvider.of<ProductPictureCubit>(context).resetImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        reset();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Add Products'.text.color(colorName.black).makeCentered(),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.go(routeName.home);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is AdminIsSuccess) {
                reset();
                Commons().showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              return VStack([
                _buildProductFrom(),
                ButtonWidget(
                  onPressed: () {
                    BlocProvider.of<AdminBloc>(context).add(AddProduct(
                      name: productNameController.text,
                      description: productDescController.text,
                      category: productCategoryController.text,
                      stock: productStockController.text,
                      price: double.parse(productPriceController.text),
                    ));
                  },
                  isLoading: (state is AdminIsLoading) ? true : false,
                  text: 'Upload',
                ).p16()
              ]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductFrom() {
    return VStack([
      TextAdmin(
        controller: productNameController,
        title: 'Product Name',
      ),
      TextAdmin(
        controller: productPriceController,
        title: 'Product Price',
      ),
      TextAdmin(
        controller: productDescController,
        title: 'Product Description',
      ),
      TextAdmin(
        controller: productCategoryController,
        title: 'Product Category',
      ),
      TextAdmin(
        controller: productStockController,
        title: 'Product Stock',
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ZStack(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      state.file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductPictureCubit>(context).getImage();
                    },
                    icon: const Icon(Icons.image),
                  )
                      .box
                      .color(colorName.white.withOpacity(.8))
                      .roundedFull
                      .make(),
                ],
                alignment: Alignment.center,
              ),
            );
          }
          return IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).getImage();
            },
            icon: const Icon(Icons.image),
          );
        },
      )
    ]).p16();
  }
}
