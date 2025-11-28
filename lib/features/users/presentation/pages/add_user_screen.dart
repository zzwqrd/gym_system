import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';
import 'package:gym_system/features/users/presentation/cubit/add_user_cubit.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserCubit(UsersUseCaseImpl()),
      child: const AddUserScreenBody(),
    );
  }
}

class AddUserScreenBody extends StatefulWidget {
  const AddUserScreenBody({super.key});

  @override
  State<AddUserScreenBody> createState() => _AddUserScreenBodyState();
}

class _AddUserScreenBodyState extends State<AddUserScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Add New User'.text),
      body: BlocListener<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Refresh users list if possible and pop
            // Note: Ideally we should use a shared event bus or pass the cubit
            Navigator.pop(context, true);
          } else if (state is AddUserFailure) {
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
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
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
                30.verticalSpace,
                BlocBuilder<AddUserCubit, AddUserState>(
                  builder: (context, state) {
                    if (state is AddUserLoading) {
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
                        child: 'Save User'.text.bold().size(16),
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
      final user = UserModel(
        username: _usernameController.text,
        email: _emailController.text,
        passwordHash: _passwordController.text, // In real app, hash this!
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        token: DateTime.now().toIso8601String(), // Simple token generation
      );
      context.read<AddUserCubit>().addUser(user);
    }
  }
}
