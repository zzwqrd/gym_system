import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';
import 'package:gym_system/features/admin/presentation/cubit/edit_admin_cubit.dart';

class EditAdminScreen extends StatelessWidget {
  final AdminModel admin;

  const EditAdminScreen({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAdminCubit(AdminsUseCaseImpl())..getRoles(),
      child: EditAdminScreenBody(admin: admin),
    );
  }
}

class EditAdminScreenBody extends StatefulWidget {
  final AdminModel admin;

  const EditAdminScreenBody({super.key, required this.admin});

  @override
  State<EditAdminScreenBody> createState() => _EditAdminScreenBodyState();
}

class _EditAdminScreenBodyState extends State<EditAdminScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  int? _selectedRoleId;
  bool _isActive = true;
  List<Map<String, dynamic>> _roles = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.admin.name);
    _emailController = TextEditingController(text: widget.admin.email);
    _selectedRoleId = widget.admin.roleId;
    _isActive = widget.admin.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Edit Admin'.text),
      body: BlocConsumer<EditAdminCubit, EditAdminState>(
        listener: (context, state) {
          if (state is EditAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is EditAdminFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is EditRolesLoaded) {
            setState(() {
              _roles = state.roles;
            });
          }
        },
        builder: (context, state) {
          if (state is EditAdminLoading && _roles.isEmpty) {
            return const CircularProgressIndicator().center;
          }
          return SingleChildScrollView(
            padding: 20.p,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    validator: (v) => v?.isEmpty == true ? 'Required' : null,
                  ),
                  15.verticalSpace,
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v?.isEmpty == true ? 'Required' : null,
                  ),
                  15.verticalSpace,
                  DropdownButtonFormField<int>(
                    value: _selectedRoleId,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(borderRadius: 10.r),
                      contentPadding: 15.p,
                    ),
                    items: _roles.map((role) {
                      return DropdownMenuItem<int>(
                        value: role['id'] as int,
                        child: Text(role['display_name'] ?? role['name']),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedRoleId = val;
                      });
                    },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  15.verticalSpace,
                  SwitchListTile(
                    title: 'Active Status'.text,
                    value: _isActive,
                    onChanged: (val) {
                      setState(() {
                        _isActive = val;
                      });
                    },
                  ),
                  30.verticalSpace,
                  if (state is EditAdminLoading)
                    const CircularProgressIndicator().center
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: 10.r),
                        ),
                        child: 'Update Admin'.text.bold().size(16),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: 10.r),
        contentPadding: 15.p,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedAdmin = widget.admin.copyWith(
        name: _nameController.text,
        email: _emailController.text,
        roleId: _selectedRoleId,
        isActive: _isActive,
      );
      context.read<EditAdminCubit>().updateAdmin(updatedAdmin);
    }
  }
}
