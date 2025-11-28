import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';

// States
abstract class AddAdminState {}

class AddAdminInitial extends AddAdminState {}

class AddAdminLoading extends AddAdminState {}

class AddAdminSuccess extends AddAdminState {
  final String message;
  AddAdminSuccess(this.message);
}

class AddAdminFailure extends AddAdminState {
  final String message;
  AddAdminFailure(this.message);
}

class RolesLoaded extends AddAdminState {
  final List<Map<String, dynamic>> roles;
  RolesLoaded(this.roles);
}

// Cubit
class AddAdminCubit extends Cubit<AddAdminState> {
  final AdminsUseCase _adminsUseCase;

  AddAdminCubit(this._adminsUseCase) : super(AddAdminInitial());

  List<Map<String, dynamic>> _roles = [];

  Future<void> getRoles() async {
    emit(AddAdminLoading());
    final response = await _adminsUseCase.getRoles();

    if (response.state == ResponseState.success) {
      _roles = List<Map<String, dynamic>>.from(response.data);
      emit(RolesLoaded(_roles));
    } else {
      emit(AddAdminFailure(response.message ?? 'Failed to load roles'));
    }
  }

  Future<void> addAdmin(AdminModel admin) async {
    emit(AddAdminLoading());
    final response = await _adminsUseCase.addAdmin(admin);

    if (response.state == ResponseState.success) {
      emit(AddAdminSuccess(response.message ?? 'Admin added successfully'));
    } else {
      emit(AddAdminFailure(response.message ?? 'Failed to add admin'));
      // Re-emit roles so the UI can rebuild properly if needed, or handle differently
      if (_roles.isNotEmpty) {
        emit(RolesLoaded(_roles));
      }
    }
  }
}
