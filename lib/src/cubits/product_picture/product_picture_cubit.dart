import 'dart:io';

import 'package:final_project_salt/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  void getImage() async {
    final listData = (state is ProductPictureIsLoaded)
        ? (state as ProductPictureIsLoaded).file
        : <File>[];

    final file = await Commons().getImage();
    if (file.path.isNotEmpty) {
      listData.add(file);
      emit(ProductPictureIsLoaded(file: listData));
    } else {
      emit(ProductPictureIsFailed());
    }
  }

  void resetImage() {
    emit(ProductPictureInitial());
  }

  void deleteImage(int id) {
    final listData = (state as ProductPictureIsLoaded).file;
    listData.removeAt(id);
    emit(ProductPictureIsLoaded(file: listData));
  }
}
