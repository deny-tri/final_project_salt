import 'package:final_project_salt/src/cubits/cubits.dart';
import 'package:final_project_salt/src/models/models.dart';
import 'package:final_project_salt/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ProductPictureCubit productPictureCubit;
  AdminBloc(this.productPictureCubit) : super(AdminInitial()) {
    on<AddProduct>((event, emit) async {
      emit(AdminIsLoading());
      ProductModel data = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: DateTime.now(),
        name: event.name,
        price: event.price,
        description: event.description,
        stock: event.stock,
        category: event.category!.split(', '),
        type: event.type!.split(', '),
      );
      final result = await AdminService().addNewProduct(data,
          file: (productPictureCubit.state is ProductPictureIsLoaded)
              ? (productPictureCubit.state as ProductPictureIsLoaded).file
              : null);

      result.fold((l) => emit(AdminIsFailed(message: l)),
          (r) => emit(AdminIsSuccess(message: r)));
    });
  }
}
