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
  final TextEditingController productTypeController = TextEditingController();
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
          title: 'Add Products'
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: colorName.accentRed,
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
                      type: productTypeController.text,
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
      6.heightBox,
      TextAdmin(
        controller: productPriceController,
        title: 'Product Price',
      ),
      6.heightBox,
      TextAdmin(
        controller: productDescController,
        title: 'Product Description',
      ),
      6.heightBox,
      TextAdmin(
        controller: productCategoryController,
        title: 'Product Category',
      ),
      6.heightBox,
      TextAdmin(
        controller: productTypeController,
        title: 'Product Type',
      ),
      6.heightBox,
      TextAdmin(
        controller: productStockController,
        title: 'Product Stock',
      ),
      8.heightBox,
      BlocBuilder<ProductPictureCubit, ProductPictureState>(
        builder: (context, state) {
          if (state is ProductPictureIsLoaded && state.file.isNotEmpty) {
            return AspectRatio(
                aspectRatio: 16 / 7,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return (index == state.file.length)
                          ? _buildAddImageButton(context)
                          : _buildImage(
                              context: context,
                              image: state.file[index],
                              index: index);
                    },
                    separatorBuilder: (context, index) => 16.widthBox,
                    itemCount: state.file.length + 1));
          }
          return _buildAddImageButton(context);
        },
      )
    ]).p16();
  }

  Widget _buildAddImageButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<ProductPictureCubit>(context).getImage();
      },
      icon: const Icon(Icons.add_a_photo_rounded),
    ).box.color(colorName.white.withOpacity(.8)).roundedFull.make();
  }

  Widget _buildImage(
      {required BuildContext context,
      required File image,
      required int index}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ZStack(
        [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<ProductPictureCubit>(context).deleteImage(index);
            },
            icon: const Icon(Icons.delete_forever),
          ).box.color(colorName.white.withOpacity(.8)).roundedFull.make(),
        ],
        alignment: Alignment.center,
      ),
    );
  }
}
