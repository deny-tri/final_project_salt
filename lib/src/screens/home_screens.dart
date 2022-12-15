part of 'screens.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  late bool _isLoading;
  late bool _isLoadingApp;
  late CountdownTimerController controller;
  int endTime = DateTime(2022, 12, 25, 12, 48, 00).millisecondsSinceEpoch;
  @override
  void initState() {
    _isLoadingApp = true;
    _isLoading = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoadingApp = false;
      });
    });
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserIsFailed) {
                Commons().showSnackBar(context, state.message);
              } else if (state is UserIsLogOut) {
                context.go(routeName.login);
              }
            },
            builder: (context, state) {
              if (state is UserIsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserIsSuccess) {
                return VStack(
                  [
                    _buildAppbar(context, state.data),
                    24.heightBox,
                    _buildBannerHome(context),
                    24.heightBox,
                    _buildMenuHome(context),
                    24.heightBox,
                    HStack([
                      'Promo'.text.bold.fontFamily('Poppins').make(),
                      20.widthBox,
                      CountdownTimer(
                        controller: controller,
                        onEnd: onEnd,
                        endTime: endTime,
                        textStyle: const TextStyle(
                            color: colorName.accentRed,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                    8.heightBox,
                    VxBox(
                      child: _buildListProduct(),
                    )
                        .size(context.percentWidth * 100,
                            context.percentHeight * 20)
                        .make(),
                    8.heightBox,
                    HStack(
                      [
                        'Recommend'.text.bold.fontFamily('Poppins').make(),
                        GestureDetector(
                          onTap: () {
                            context.go(routeName.productPath);
                          },
                          child: HStack([
                            'View All'
                                .text
                                .color(colorName.accentRed)
                                .fontFamily('Poppins')
                                .make(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: colorName.accentRed,
                              size: 14,
                            )
                          ]),
                        )
                      ],
                      alignment: MainAxisAlignment.spaceBetween,
                      axisSize: MainAxisSize.max,
                    ),
                    8.heightBox,
                    VxBox(
                      child: _buildRekomend(),
                    )
                        .size(context.percentWidth * 100,
                            context.percentHeight * 50)
                        .make(),
                  ],
                  alignment: MainAxisAlignment.start,
                  axisSize: MainAxisSize.max,
                ).scrollVertical();
              }
              return 0.heightBox;
            },
          ).p16().centered().box.make(),
        ),
      ),
    );
  }

  Widget _buildBannerHome(BuildContext context) {
    return _isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade500.withOpacity(0.5),
            child: VxSwiper(
                autoPlay: true,
                items: [
                  "https://assets.digination.id/crop/0x0:0x0/x/photo/2021/03/19/3776868825.png",
                  "https://www.qiscus.com/id/wp-content/uploads/sites/2/2022/04/Cara-menghitung-diskon.png",
                  "https://png.pngtree.com/png-vector/20210920/ourmid/pngtree-flat-promo-sale-icon-label-png-image_3942688.png",
                  "https://kicaunews.com/wp-content/uploads/2022/02/8E0068FF-8604-4E9B-A839-F2B71D8A4FEC.png",
                ].map((index) {
                  return Image.network(
                    index,
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: 250,
                  ).box.rounded.outerShadow.white.alignCenter.make().p4();
                }).toList()),
          )
        : VxSwiper(
            autoPlay: true,
            items: [
              "https://assets.digination.id/crop/0x0:0x0/x/photo/2021/03/19/3776868825.png",
              "https://www.qiscus.com/id/wp-content/uploads/sites/2/2022/04/Cara-menghitung-diskon.png",
              "https://png.pngtree.com/png-vector/20210920/ourmid/pngtree-flat-promo-sale-icon-label-png-image_3942688.png",
              "https://kicaunews.com/wp-content/uploads/2022/02/8E0068FF-8604-4E9B-A839-F2B71D8A4FEC.png",
            ].map((index) {
              return Image.network(
                index,
                fit: BoxFit.cover,
                height: 150.0,
                width: 250,
              ).box.rounded.outerShadow.white.alignCenter.make().p4();
            }).toList());
  }

  Widget _buildMenuHome(BuildContext context) {
    return HStack(
      [
        VStack([
          IconButton(
            onPressed: () {
              context.go(routeName.productPath);
            },
            icon: const Icon(
              Icons.shopping_bag_rounded,
              color: colorName.accentRed,
            ),
          ),
          'Product'
              .text
              .bold
              .color(colorName.black)
              .fontFamily('Poppins')
              .makeCentered(),
        ]),
        VStack([
          IconButton(
            onPressed: () {
              context.go(routeName.wishlistPath);
            },
            icon: const Icon(
              Icons.favorite_border_rounded,
              color: colorName.accentRed,
            ),
          ),
          'Favorite'
              .text
              .bold
              .color(colorName.black)
              .fontFamily('Poppins')
              .makeCentered(),
        ]),
        VStack(
          [
            IconButton(
              onPressed: () {
                context.go(routeName.historiPath);
              },
              icon: const Icon(
                Icons.wallet,
                color: colorName.accentRed,
              ),
            ),
            'History'
                .text
                .bold
                .color(colorName.black)
                .fontFamily('Poppins')
                .makeCentered()
          ],
        )
      ],
      alignment: MainAxisAlignment.spaceBetween,
      axisSize: MainAxisSize.max,
    )
        .p16()
        .box
        .outerShadow
        .color(colorName.white)
        .size(context.safePercentWidth * 100, context.safePercentHeight * 15)
        .make();
  }

  Widget _buildAppbar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          HStack([
            _isLoadingApp
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade500.withOpacity(0.5),
                    child: VxCircle(
                      radius: 56,
                      backgroundImage: (data.photoProfile!.isNotEmpty)
                          ? DecorationImage(
                              image: NetworkImage(data.photoProfile!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: NetworkImage(
                                  "https://perpustakaan.unej.ac.id/wp-content/uploads/2016/09/person-icon.png"),
                              fit: BoxFit.cover,
                            ),
                    ).onTap(() {
                      context.go(routeName.profilePath);
                    }),
                  )
                : VxCircle(
                    radius: 56,
                    backgroundImage: (data.photoProfile!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(data.photoProfile!),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: NetworkImage(
                                "https://perpustakaan.unej.ac.id/wp-content/uploads/2016/09/person-icon.png"),
                            fit: BoxFit.cover,
                          ),
                  ).onTap(() {
                    context.go(routeName.profilePath);
                  }),
            16.widthBox,
            _isLoadingApp
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade500.withOpacity(0.5),
                    child: VStack([
                      VxBox().outerShadow.white.size(100, 10).make(),
                      16.heightBox,
                      VxBox().outerShadow.white.size(150, 20).make(),
                    ]))
                : 'Good ${Commons().greeting()},\n'
                    .richText
                    .color(colorName.black)
                    .size(12)
                    .fontFamily('Poppins')
                    .withTextSpanChildren([
                    data.username!.textSpan.bold.size(18).make(),
                  ]).make(),
          ]).expand(),
          IconButton(
            onPressed: () {
              final cubit = context.read<DarkThemeCubit>();
              cubit.darkTheme();
            },
            icon: const Icon(
              Icons.dark_mode,
              color: colorName.accentRed,
            ),
          ),
          BlocBuilder<CartCountCubit, CartCountState>(
            builder: (context, state) {
              return ZStack(
                [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CheckboxCartCubit>(context)
                          .removeAllCheckBox();
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
    ).gray100.p4.make();
  }

  Widget _buildListProduct() {
    return BlocConsumer<ListProductBloc, ListProductState>(
      listener: (context, state) {
        if (state is ListProductIsFailed) {
          Commons().showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ListProductIsLoading) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        if (state is ListProductIsSuccess) {
          final data = state.products;
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 150.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProductHome(
                productHome: data[index],
              );
            },
          );
        }

        return 0.heightBox;
      },
    );
  }

  Widget _buildRekomend() {
    return BlocConsumer<ListProductBloc, ListProductState>(
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

        return 0.heightBox;
      },
    );
  }
}
