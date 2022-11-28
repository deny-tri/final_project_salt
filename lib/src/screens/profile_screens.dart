part of 'screens.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return const CircularProgressIndicator().centered();
            } else if (state is UserIsSuccess) {
              return VStack(
                [
                  _buildAppbar(context, state.data),
                  24.heightBox,
                ],
                alignment: MainAxisAlignment.start,
                axisSize: MainAxisSize.max,
              );
            }
            return 0.heightBox;
          },
        ).p16().centered(),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, UserModel data) {
    return VxBox(
      child: HStack(
        [
          HStack([
            VxCircle(
              radius: 80,
              backgroundImage: (data.photoProfile!.isNotEmpty)
                  ? DecorationImage(
                      image: NetworkImage(data.photoProfile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ).onTap(() {
              context.go(routeName.adminPath);
            }),
            16.widthBox,
            '${Commons().greeting()},\n'
                .richText
                .size(12)
                .withTextSpanChildren([
              data.username!.textSpan.bold.size(18).make(),
            ]).make(),
          ]).expand(),
          IconButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LogOutUser());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
    ).gray100.make();
  }
}
