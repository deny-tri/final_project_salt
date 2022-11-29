// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class ProductWidgets extends StatelessWidget {
  final ProductModel products;

  const ProductWidgets({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: VStack(
        [
          GestureDetector(
            onTap: () {
              context.go(routeName.detailPath, extra: products.id);
            },
            child: VxBox(
              child: Image(
                image: NetworkImage(products.picture![0]),
              ),
            )
                .size(context.safePercentWidth * 100,
                    context.safePercentHeight * 10)
                .makeCentered(),
          ),
          products.name!.text.bodyText1(context).make(),
          products.price!.text.bodyText1(context).make(),
        ],
      ),
    );
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: VStack(
        [
          GestureDetector(
            onTap: () {
              context.go(routeName.detailPath, extra: productHome.id);
            },
            child: AspectRatio(
              aspectRatio: 19 / 9,
              child: Image(
                image: NetworkImage(productHome.picture![0]),
              ),
            ).p8(),
          ),
          productHome.name!.text
              .color(colorName.black)
              .bodyText1(context)
              .makeCentered(),
          productHome.price!.text
              .color(colorName.black)
              .bodyText1(context)
              .makeCentered(),
        ],
      ).box.outerShadow.white.margin(Vx.m12).make(),
    );
  }
}
