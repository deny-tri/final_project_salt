part of 'widgets.dart';

class AppSearch extends StatelessWidget {
  const AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        VxBox(
          child: const TextField(
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
            ),
          ),
        )
            .size(context.safePercentWidth, context.safePercentHeight * 0.7)
            .make(),
        InkWell(
          onTap: () {},
        )
      ],
    ).p16();
  }
}
