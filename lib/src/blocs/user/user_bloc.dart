import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:final_project_salt/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserIsLoading());
      String? uid = await Commons().getUID();
      final result = await UserServices().loadUserData(uid);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return UserIsSuccess(data: r);
          },
        ),
      );
    });
    on<LogOutUser>((event, emit) async {
      emit(UserIsLogOut());
      await Commons().removeUID();
      UserServices().logOutUser();
    });
    on<ChangePhoto>((event, emit) async {
      final result =
          await UserServices().changeProfile((state as UserIsSuccess).data);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) => UserIsSuccess(data: r),
        ),
      );
    });
    on<AuthGoogle>((event, emit) async {
      emit(UserIsLoading());
      final result = await UserServices().signInWithGoogle();
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return UserIsSuccess(data: r);
          },
        ),
      );
    });
  }
}
