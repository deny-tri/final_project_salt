import 'package:final_project_salt/src/blocs/blocs.dart';
import 'package:final_project_salt/src/cubits/cubits.dart';
import 'package:final_project_salt/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ProductPictureCubit()),
        BlocProvider(create: (context) => ListProductBloc()),
        BlocProvider(create: (context) => DetailProductsBloc()),
        BlocProvider(create: (context) => ListWishlistBloc()),
        BlocProvider(create: (context) => CheckSavedCubit()),
        BlocProvider(create: (context) => CheckCategoryCubit()),
        BlocProvider(create: (context) => CartCountCubit()),
        BlocProvider(create: (context) => WishlistCountCubit()),
        BlocProvider(create: (context) => ListCartBloc()),
        BlocProvider(create: (context) => CheckboxCartCubit()),
        BlocProvider(create: (context) => DarkThemeCubit()),
        BlocProvider(create: (context) => AddToCartBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => ListOrderBloc()),
        BlocProvider(
            create: (context) =>
                WishlistCubit(BlocProvider.of<CheckSavedCubit>(context))),
        BlocProvider(
            create: (context) =>
                AdminBloc(BlocProvider.of<ProductPictureCubit>(context))),
      ],
      child: BlocBuilder<DarkThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: state,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
