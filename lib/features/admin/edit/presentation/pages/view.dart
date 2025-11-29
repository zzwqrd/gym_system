import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../data/model/model.dart';
import '../../data/model/send_data.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class EditAdminView extends StatefulWidget {
  final Admin admin;
  const EditAdminView({super.key, required this.admin});

  @override
  State<EditAdminView> createState() => _EditAdminViewState();
}

class _EditAdminViewState extends State<EditAdminView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.admin.name);
    _emailController = TextEditingController(text: widget.admin.email);
    _passwordController = TextEditingController();
    _isActive = widget.admin.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAdminController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تعديل مسؤول')),
        body: BlocConsumer<EditAdminController, EditAdminState>(
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
                    title: 'كلمة المرور (اختياري)',
                    controller: _passwordController,
                    fieldType: FieldType.password,
                    isRequired: false,
                  ).pb4,
                  SwitchListTile(
                    title: const Text('نشط'),
                    value: _isActive,
                    onChanged: (val) => setState(() => _isActive = val),
                  ).pb6,
                  LoadingButton(
                    title: 'حفظ التعديلات',
                    isAnimating: state.requestState == RequestState.loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final sendData = SendData(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text.isEmpty
                              ? null
                              : _passwordController.text,
                          roleId: widget.admin.roleId,
                          isActive: _isActive,
                        );
                        context.read<EditAdminController>().updateAdmin(
                          widget.admin.id,
                          sendData,
                        );
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
