part of 'screens.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: VStack([
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: 'Reset'.text.make(),
            )
          ]).p4(),
        ),
      ),
    );
  }
}
