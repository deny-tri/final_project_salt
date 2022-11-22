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
                    // child: Image(
                    //   image: NetworkImage(products.picture!),
                    // ),
                    )
                .size(context.safePercentWidth * 100,
                    context.safePercentHeight * 10)
                .make(),
            // child: Image.network(
            //   products.picture!,
            //   fit: BoxFit.cover,
            // ),
          ),
          products.name!.text.bodyText1(context).make(),
          products.price!.text.bodyText1(context).make(),
        ],
      ),
    );
  }
}
