part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const home = '/home';
  static const admin = 'admin';
  static const adminPath = '/home/admin';
  static const detail = 'detail';
  static const detailPath = '/home/detail';
  static const profile = 'profile';
  static const profilePath = '/home/profile';
  static const product = 'product';
  static const productPath = '/home/product';
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
      path: routeName.home,
      builder: (context, state) {
        BlocProvider.of<UserBloc>(context).add(LoadUserData());
        BlocProvider.of<ListProductBloc>(context).add(FetchListProduct());
        return const HomeScreens();
      },
      routes: [
        GoRoute(
            path: routeName.profile,
            builder: (context, state) {
              return const ProfileScreens();
            }),
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
            path: routeName.detail,
            builder: (context, state) {
              final String id = state.extra as String;
              BlocProvider.of<DetailProductsBloc>(context)
                  .add(FetchDetailProduct(docID: id));
              return const DetailProduct();
            }),
      ]),
]);
