part of 'screens.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        'Reptic Pedia'.text.bold.make(),
      ]).centered(),
    );
  }
}
