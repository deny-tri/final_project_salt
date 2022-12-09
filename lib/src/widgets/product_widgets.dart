// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field
part of 'widgets.dart';

class ProductWidgets extends StatefulWidget {
  final ProductModel products;

  const ProductWidgets({super.key, required this.products});

  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  late bool _isShimmer;

  @override
  void initState() {
    _isShimmer = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isShimmer = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isShimmer
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade500.withOpacity(0.5),
            child: VStack([
              GestureDetector(
                onTap: () {
                  context.go(routeName.detailPath, extra: widget.products.id);
                },
                child: AspectRatio(
                  aspectRatio: 14 / 10,
                  child: Image(
                    image: NetworkImage(widget.products.picture![0]),
                  ),
                ),
              ),
              widget.products.name!.text
                  .color(colorName.black)
                  .bodyText1(context)
                  .make(),
              Commons()
                  .setPriceToIDR(widget.products.price!)
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
                .make(),
          )
        : VStack([
            GestureDetector(
              onTap: () {
                context.go(routeName.detailPath, extra: widget.products.id);
              },
              child: AspectRatio(
                aspectRatio: 14 / 10,
                child: Image(
                  image: NetworkImage(widget.products.picture![0]),
                ),
              ),
            ),
            widget.products.name!.text
                .color(colorName.black)
                .bodyText1(context)
                .make(),
            Commons()
                .setPriceToIDR(widget.products.price!)
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

class ProductHome extends StatefulWidget {
  final ProductModel productHome;
  const ProductHome({
    Key? key,
    required this.productHome,
  }) : super(key: key);

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  late bool _isShimmer;
  @override
  void initState() {
    _isShimmer = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isShimmer = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isShimmer
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade500.withOpacity(0.5),
            child: VStack([
              GestureDetector(
                onTap: () {
                  context.go(routeName.detailPath,
                      extra: widget.productHome.id);
                },
                child: AspectRatio(
                  aspectRatio: 14 / 10,
                  child: Image(
                    image: NetworkImage(widget.productHome.picture![0]),
                  ),
                ),
              ),
              widget.productHome.name!.text
                  .color(colorName.black)
                  .bodyText1(context)
                  .make(),
              Commons()
                  .setPriceToIDR(widget.productHome.price!)
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
                .make(),
          )
        : VStack([
            GestureDetector(
              onTap: () {
                context.go(routeName.detailPath, extra: widget.productHome.id);
              },
              child: AspectRatio(
                aspectRatio: 14 / 10,
                child: Image(
                  image: NetworkImage(widget.productHome.picture![0]),
                ),
              ),
            ),
            widget.productHome.name!.text
                .color(colorName.black)
                .bodyText1(context)
                .make(),
            Commons()
                .setPriceToIDR(widget.productHome.price!)
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
