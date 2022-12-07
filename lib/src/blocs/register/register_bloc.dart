import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:final_project_salt/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegisterIsLoading());
      final result = await UserServices().registerWithEmail(
          email: event.email, name: event.username, password: event.password);
      emit(
        result.fold(
          (l) => RegisterIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return RegisterIsSuccess(data: r);
          },
        ),
      );
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(RegisterIsLoading());
      final result = await UserServices().signInWithGoogle();
      emit(
        result.fold(
          (l) => RegisterIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return RegisterIsSuccess(data: r);
          },
        ),
      );
    });
  }
}
