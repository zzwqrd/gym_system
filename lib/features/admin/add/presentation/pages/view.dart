import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_system/commonWidget/toast_helper.dart';
import 'package:gym_system/di/service_locator.dart';
import '../../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/send_data.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class AddAdminView extends StatefulWidget {
  const AddAdminView({super.key});

  @override
  State<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<AddAdminController>();
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('إضافة مسؤول')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              AppCustomForm(
                title: 'الاسم',
                controller: _nameController,
                fieldType: FieldType.name,
                isRequired: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الاسم مطلوب';
                  }
                  return null;
                },
              ).pb4,
              AppCustomForm(
                title: 'البريد الإلكتروني',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'البريد الإلكتروني مطلوب';
                  }
                  return null;
                },
                controller: _emailController,
                fieldType: FieldType.email,
                isRequired: true,
              ).pb4,
              AppCustomForm(
                title: 'كلمة المرور',
                controller: _passwordController,
                fieldType: FieldType.password,
                isRequired: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'كلمة المرور مطلوبة';
                  }
                  return null;
                },
              ).pb4,
              SwitchListTile(
                key: ValueKey(_isActive),
                title: 'نشط'.h6,
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
              ).pb6,
              BlocConsumer<AddAdminController, AddAdminState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.requestState.isDone) {
                    Navigator.pop(context);
                  } else if (state.requestState.isError) {
                    FlashHelper.showToast(
                      state.errorMessage,
                      type: MessageTypeTost.fail,
                    );
                  }
                },
                builder: (context, state) {
                  return LoadingButton(
                    title: 'إضافة',
                    isAnimating: state.requestState.isLoading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final sendData = SendData(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          roleId: 1, // Default role for now
                          isActive: _isActive,
                        );
                        bloc.addAdmin(sendData);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
