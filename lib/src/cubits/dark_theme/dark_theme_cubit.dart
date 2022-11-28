import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dark_theme_state.dart';

class DarkThemeCubit extends Cubit<ThemeData> {
  DarkThemeCubit() : super(ThemeData());

  void darkTheme() {
    if (state == ThemeData.light()) {
      emit(ThemeData.dark());
    } else {
      emit(ThemeData.light());
    }
  }
}
