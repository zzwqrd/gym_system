import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/send_data.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('إضافة مشترك')),
        body: BlocConsumer<AddUserController, AddUserState>(
          listener: (context, state) {
            if (state.requestState == RequestState.done) {
              Navigator.pop(context);
            } else if (state.requestState == RequestState.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  AppCustomForm(
                    title: 'الاسم',
                    controller: _nameController,
                    fieldType: FieldType.name,
                    isRequired: true,
                  ).pb4,
                  AppCustomForm(
                    title: 'البريد الإلكتروني',
                    controller: _emailController,
                    fieldType: FieldType.email,
                    isRequired: true,
                  ).pb4,
                  AppCustomForm(
                    title: 'رقم الهاتف',
                    controller: _phoneController,
                    fieldType: FieldType.phone,
                    isRequired: true,
                  ).pb4,
                  AppCustomForm(
                    title: 'رقم الهوية',
                    controller: _nationalIdController,
                    fieldType: FieldType.number,
                    isRequired: false,
                  ).pb4,
                  AppCustomForm(
                    title: 'كلمة المرور',
                    controller: _passwordController,
                    fieldType: FieldType.password,
                    isRequired: true,
                  ).pb4,
                  SwitchListTile(
                    title: const Text('نشط'),
                    value: _isActive,
                    onChanged: (val) => setState(() => _isActive = val),
                  ).pb6,
                  LoadingButton(
                    title: 'إضافة',
                    isAnimating: state.requestState == RequestState.loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final sendData = SendData(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          phone: _phoneController.text,
                          nationalId: _nationalIdController.text.isEmpty
                              ? null
                              : _nationalIdController.text,
                          isActive: _isActive,
                        );
                        context.read<AddUserController>().addUser(sendData);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
