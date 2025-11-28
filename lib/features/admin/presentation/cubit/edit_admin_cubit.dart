import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';

// States
abstract class EditAdminState {}

class EditAdminInitial extends EditAdminState {}

class EditAdminLoading extends EditAdminState {}

class EditAdminSuccess extends EditAdminState {
  final String message;
  EditAdminSuccess(this.message);
}

class EditAdminFailure extends EditAdminState {
  final String message;
  EditAdminFailure(this.message);
}

class EditRolesLoaded extends EditAdminState {
  final List<Map<String, dynamic>> roles;
  EditRolesLoaded(this.roles);
}

// Cubit
class EditAdminCubit extends Cubit<EditAdminState> {
  final AdminsUseCase _adminsUseCase;

  EditAdminCubit(this._adminsUseCase) : super(EditAdminInitial());

  List<Map<String, dynamic>> _roles = [];

  Future<void> getRoles() async {
    emit(EditAdminLoading());
    final response = await _adminsUseCase.getRoles();

    if (response.state == ResponseState.success) {
      _roles = List<Map<String, dynamic>>.from(response.data);
      emit(EditRolesLoaded(_roles));
    } else {
      emit(EditAdminFailure(response.message ?? 'Failed to load roles'));
    }
  }

  Future<void> updateAdmin(AdminModel admin) async {
    emit(EditAdminLoading());
    final response = await _adminsUseCase.updateAdmin(admin);

    if (response.state == ResponseState.success) {
      emit(EditAdminSuccess(response.message ?? 'Admin updated successfully'));
    } else {
      emit(EditAdminFailure(response.message ?? 'Failed to update admin'));
      if (_roles.isNotEmpty) {
        emit(EditRolesLoaded(_roles));
      }
    }
  }
}
