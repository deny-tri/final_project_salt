// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class ProductWidgets extends StatelessWidget {
  final ProductModel products;

  const ProductWidgets({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    return VStack([
      GestureDetector(
        onTap: () {
          context.go(routeName.detailPath, extra: products.id);
        },
        child: AspectRatio(
          aspectRatio: 14 / 10,
          child: Image(
            image: NetworkImage(products.picture![0]),
          ),
        ),
      ),
      products.name!.text.color(colorName.black).bodyText1(context).make(),
      Commons()
          .setPriceToIDR(products.price!)
          .text
          .color(colorName.black)
          .fontFamily('Poppins')
          .bodyText1(context)
          .make(),
    ])
        .p12()
        .box
        .shadowOutline(outlineColor: colorName.accentRed)
        .white
        .rounded
        .margin(Vx.m8)
        .make();
  }
}

class ProductHome extends StatelessWidget {
  final ProductModel productHome;
  const ProductHome({
    Key? key,
    required this.productHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VStack([
      GestureDetector(
        onTap: () {
          context.go(routeName.detailPath, extra: productHome.id);
        },
        child: AspectRatio(
          aspectRatio: 14 / 10,
          child: Image(
            image: NetworkImage(productHome.picture![0]),
          ),
        ),
      ),
      productHome.name!.text.color(colorName.black).bodyText1(context).make(),
      Commons()
          .setPriceToIDR(productHome.price!)
          .text
          .color(colorName.black)
          .bodyText1(context)
          .fontFamily('Poppins')
          .make(),
    ])
        .p12()
        .box
        .shadowOutline(outlineColor: colorName.accentRed)
        .white
        .rounded
        .margin(Vx.m8)
        .make();
  }
}
