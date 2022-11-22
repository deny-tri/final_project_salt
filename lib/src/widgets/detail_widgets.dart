part of 'widgets.dart';

class DetailProductWidgets extends StatelessWidget {
  final ProductModel data;

  const DetailProductWidgets({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Detail Product'.text.color(colorName.black).makeCentered(),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go(routeName.productPath);
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
      body: VStack(
        [
          _buildImage(context),
        ],
      ).p16(),
    );
  }

  Widget _buildImage(BuildContext context) {
    return VStack(
      [
        VxBox(
                child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          // child: Image.network(
          //   data.picture!,
          //   fit: BoxFit.cover,
          // ),
        ))
            .size(context.screenWidth, context.percentHeight * 30)
            .bottomRounded(value: 20)
            .make(),
        16.widthBox,
        data.name!.text.bold.capitalize.makeCentered(),
        'Category Produk'.text.bold.make(),
        16.widthBox,
        HStack(data.category
            .map((e) => VxBox(child: e.text.color(colorName.white).make())
                .color(colorName.grey)
                .p4
                .rounded
                .make()
                .pOnly(right: 4))
            .toList()),
        16.heightBox,
        'Description'.text.bold.capitalize.make(),
        data.description!.text.make(),
        16.heightBox,
        'Stock Available'.text.bold.capitalize.make(),
        data.stock!.text.make(),
      ],
      alignment: MainAxisAlignment.spaceEvenly,
      axisSize: MainAxisSize.max,
    );
  }
}
