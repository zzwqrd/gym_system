import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';
import 'package:gym_system/features/admin/presentation/cubit/add_admin_cubit.dart';

class AddAdminScreen extends StatelessWidget {
  const AddAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAdminCubit(AdminsUseCaseImpl())..getRoles(),
      child: const AddAdminScreenBody(),
    );
  }
}

class AddAdminScreenBody extends StatefulWidget {
  const AddAdminScreenBody({super.key});

  @override
  State<AddAdminScreenBody> createState() => _AddAdminScreenBodyState();
}

class _AddAdminScreenBodyState extends State<AddAdminScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int? _selectedRoleId;
  List<Map<String, dynamic>> _roles = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Add New Admin'.text),
      body: BlocConsumer<AddAdminCubit, AddAdminState>(
        listener: (context, state) {
          if (state is AddAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is AddAdminFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is RolesLoaded) {
            setState(() {
              _roles = state.roles;
            });
          }
        },
        builder: (context, state) {
          if (state is AddAdminLoading && _roles.isEmpty) {
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
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
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
                  30.verticalSpace,
                  if (state is AddAdminLoading)
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
                        child: 'Save Admin'.text.bold().size(16),
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
    bool obscureText = false,
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
      obscureText: obscureText,
      validator: validator,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final admin = AdminModel(
        name: _nameController.text,
        email: _emailController.text,
        passwordHash: _passwordController.text, // Hash in real app
        roleId: _selectedRoleId!,
        token: DateTime.now().toIso8601String(),
      );
      context.read<AddAdminCubit>().addAdmin(admin);
    }
  }
}
