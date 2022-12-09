part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const resetpass = '/resetpass';
  static const home = '/home';
  static const admin = 'admin';
  static const adminPath = '/home/admin';
  static const detail = 'detail';
  static const detailPath = '/home/detail';
  static const profile = 'profile';
  static const profilePath = '/home/profile';
  static const product = 'product';
  static const productPath = '/home/product';
  static const cart = 'cart';
  static const cartPath = '/home/cart';
  static const wistlist = 'wistlist';
  static const wishlistPath = '/home/wistlist';
  static const histori = 'histori';
  static const historiPath = '/home/histori';
}

final GoRouter router = GoRouter(initialLocation: routeName.splash, routes: [
  GoRoute(
    path: routeName.splash,
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        Commons().setUID(FirebaseAuth.instance.currentUser!.uid);
        BlocProvider.of<UserBloc>(context).add(LoadUserData());
        return routeName.home;
      } else {
        return routeName.register;
      }
    },
    builder: (context, state) {
      return const SplashScreens();
    },
  ),
  GoRoute(
    path: routeName.register,
    builder: (context, state) {
      return const RegisterScreens();
    },
  ),
  GoRoute(
    path: routeName.login,
    builder: (context, state) {
      BlocProvider.of<UserBloc>(context).add(LoadUserData());
      return const LoginScreens();
    },
  ),
  GoRoute(
    path: routeName.resetpass,
    builder: (context, state) {
      return const ResetPassword();
    },
  ),
  GoRoute(
      path: routeName.home,
      builder: (context, state) {
        BlocProvider.of<UserBloc>(context).add(LoadUserData());
        BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
        BlocProvider.of<CartCountCubit>(context).getCartCount();
        BlocProvider.of<WishlistCountCubit>(context).getWishlistCount();
        return const HomeScreens();
      },
      routes: [
        GoRoute(
          path: routeName.cart,
          builder: (context, state) {
            BlocProvider.of<ListCartBloc>(context).add(FetchListCart());
            return const CartScreen();
          },
        ),
        GoRoute(
          path: routeName.histori,
          builder: (context, state) {
            BlocProvider.of<ListOrderBloc>(context).add(FetchListOrder());
            BlocProvider.of<ListWishlistBloc>(context).add(FetchListWishlist());
            return const HistoriScreens();
          },
        ),
        GoRoute(
          path: routeName.profile,
          builder: (context, state) {
            return const ProfileScreens();
          },
        ),
        GoRoute(
            path: routeName.product,
            builder: (context, state) {
              return const ProductScreens();
            }),
        GoRoute(
            path: routeName.admin,
            builder: (context, state) {
              return const AdminScreens();
            }),
        GoRoute(
            path: routeName.wistlist,
            builder: (context, state) {
              BlocProvider.of<ListOrderBloc>(context).add(FetchListOrder());
              BlocProvider.of<ListWishlistBloc>(context)
                  .add(FetchListWishlist());
              return const WishListScreens();
            }),
        GoRoute(
            path: routeName.detail,
            builder: (context, state) {
              String id = state.extra as String;
              BlocProvider.of<DetailProductsBloc>(context)
                  .add(FetchDetailProduct(docID: id));
              BlocProvider.of<CheckSavedCubit>(context).checkWishList(id);
              return const DetailScreen();
            }),
      ]),
]);
