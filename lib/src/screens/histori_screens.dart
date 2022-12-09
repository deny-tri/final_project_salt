part of 'screens.dart';

class HistoriScreens extends StatelessWidget {
  const HistoriScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'History'.text.color(colorName.accentRed).makeCentered(),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go(routeName.profilePath);
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
                                  .color(colorName.black)
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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
        },
        child: SafeArea(
          child: BlocBuilder<ListOrderBloc, ListOrderState>(
            builder: (context, listOrderState) {
              if (listOrderState is ListOrderIsSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: listOrderState.model.length,
                  itemBuilder: (context, index) {
                    return VStack([
                      HStack([
                        listOrderState.model[index].productName!.text
                            .color(colorName.black)
                            .make()
                            .expand(),
                        (listOrderState.model[index].paymentStatus! == 0
                                ? 'not yet paid'
                                : listOrderState.model[index].paymentStatus! ==
                                        1
                                    ? 'Order in Progress'
                                    : 'Done')
                            .text
                            .color(
                                (listOrderState.model[index].paymentStatus! == 0
                                    ? colorName.accentRed
                                    : listOrderState
                                                .model[index].paymentStatus! ==
                                            1
                                        ? colorName.accentBlue
                                        : colorName.accentGreen))
                            .make()
                      ]),
                      const VxDivider(type: VxDividerType.horizontal)
                          .backgroundColor(colorName.accentRed)
                          .py8(),
                      VStack(listOrderState.model[index].products
                          .map((e) => HStack([
                                VxBox()
                                    .size(40, 40)
                                    .bgImage(DecorationImage(
                                      image: NetworkImage(
                                        e.picture![0],
                                      ),
                                      fit: BoxFit.cover,
                                    ))
                                    .roundedSM
                                    .make(),
                                4.widthBox,
                                e.name!.text.color(colorName.black).make(),
                              ]).py4())
                          .toList()),
                      16.heightBox,
                      'Total: ${Commons().setPriceToIDR(listOrderState.model[index].totalPrice!)}'
                          .text
                          .color(colorName.black)
                          .bold
                          .make()
                          .objectBottomRight(),
                    ])
                        .p16()
                        .box
                        .roundedSM
                        .outerShadow
                        .white
                        .color(colorName.white)
                        .make()
                        .p16();
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
