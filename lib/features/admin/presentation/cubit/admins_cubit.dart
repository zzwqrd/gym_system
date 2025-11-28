import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';

// States
abstract class AdminsState {}

class AdminsInitial extends AdminsState {}

class AdminsLoading extends AdminsState {}

class AdminsLoaded extends AdminsState {
  final List<AdminModel> admins;
  AdminsLoaded(this.admins);
}

class AdminsError extends AdminsState {
  final String message;
  AdminsError(this.message);
}

// Cubit
class AdminsCubit extends Cubit<AdminsState> {
  final AdminsUseCase _adminsUseCase;

  AdminsCubit(this._adminsUseCase) : super(AdminsInitial());

  List<AdminModel> _allAdmins = [];

  Future<void> getAdmins() async {
    emit(AdminsLoading());
    final response = await _adminsUseCase.getAdmins();

    if (response.state == ResponseState.success) {
      _allAdmins = response.data as List<AdminModel>;
      emit(AdminsLoaded(_allAdmins));
    } else {
      emit(AdminsError(response.message ?? 'Failed to load admins'));
    }
  }

  Future<void> searchAdmins(String query) async {
    if (query.isEmpty) {
      emit(AdminsLoaded(_allAdmins));
      return;
    }

    final filteredAdmins = _allAdmins.where((admin) {
      final searchLower = query.toLowerCase();
      return admin.name.toLowerCase().contains(searchLower) ||
          admin.email.toLowerCase().contains(searchLower);
    }).toList();

    emit(AdminsLoaded(filteredAdmins));
  }

  Future<void> refreshAdmins() async {
    await getAdmins();
  }
}
