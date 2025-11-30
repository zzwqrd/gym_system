import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../commonWidget/button_animation/LoadingButton.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../list/data/model/model.dart';
import '../../data/model/send_data.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class EditUserView extends StatefulWidget {
  final User user;
  const EditUserView({super.key, required this.user});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _nationalIdController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _nationalIdController = TextEditingController(
      text: widget.user.nationalId ?? '',
    );
    _isActive = widget.user.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تعديل مشترك')),
        body: BlocConsumer<EditUserController, EditUserState>(
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
                          phone: _phoneController.text,
                          nationalId: _nationalIdController.text.isEmpty
                              ? null
                              : _nationalIdController.text,
                          isActive: _isActive,
                        );
                        context.read<EditUserController>().updateUser(
                          widget.user.id,
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
