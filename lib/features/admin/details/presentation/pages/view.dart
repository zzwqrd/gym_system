import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../widgets/build_content.dart';

class AdminDetailsView extends StatefulWidget {
  final int adminId;

  const AdminDetailsView({super.key, required this.adminId});

  @override
  State<AdminDetailsView> createState() => _AdminDetailsViewState();
}

class _AdminDetailsViewState extends State<AdminDetailsView> {
  final controller = sl<AdminDetailsController>();
  @override
  void initState() {
    super.initState();
    controller.getAdminById(widget.adminId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المسؤول')),
      body: BlocBuilder<AdminDetailsController, AdminDetailsState>(
        bloc: controller,
        buildWhen: (previous, current) => previous != current,

        builder: (context, state) {
          if (state.requestState == RequestState.loading) {
            return const CircularProgressIndicator().center;
          } else if (state.requestState == RequestState.error) {
            return Text(state.errorMessage).center;
          } else if (state.data == null) {
            return const Text('لا توجد بيانات').center;
          } else {
            return AdminDetailsContent(admin: state.data!);
          }
        },
      ),
    );
  }
}
