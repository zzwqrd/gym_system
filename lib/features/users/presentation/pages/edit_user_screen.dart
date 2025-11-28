import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';
import 'package:gym_system/features/users/presentation/cubit/edit_user_cubit.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserCubit(UsersUseCaseImpl()),
      child: EditUserScreenBody(user: user),
    );
  }
}

class EditUserScreenBody extends StatefulWidget {
  final UserModel user;

  const EditUserScreenBody({super.key, required this.user});

  @override
  State<EditUserScreenBody> createState() => _EditUserScreenBodyState();
}

class _EditUserScreenBodyState extends State<EditUserScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(text: widget.user.phone);
    _isActive = widget.user.isActive;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Edit User'.text),
      body: BlocListener<EditUserCubit, EditUserState>(
        listener: (context, state) {
          if (state is EditUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is EditUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: 20.p,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _usernameController,
                  label: 'Username',
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
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                      ),
                    ),
                    15.horizontalSpace,
                    Expanded(
                      child: _buildTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
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
                BlocBuilder<EditUserCubit, EditUserState>(
                  builder: (context, state) {
                    if (state is EditUserLoading) {
                      return const CircularProgressIndicator().center;
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: 10.r),
                        ),
                        child: 'Update User'.text.bold().size(16),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
      final updatedUser = widget.user.copyWith(
        username: _usernameController.text,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        isActive: _isActive,
      );
      context.read<EditUserCubit>().updateUser(updatedUser);
    }
  }
}
