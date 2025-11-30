import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../../data/model/model.dart';

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
            return _buildContent(state.data!);
          }
        },
      ),
    );
  }

  Widget _buildContent(Admin admin) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            admin.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 32),
          ),
        ).center.pb6,
        _buildDetailItem('الاسم', admin.name),
        _buildDetailItem('البريد الإلكتروني', admin.email),
        _buildDetailItem('الحالة', admin.isActive ? 'نشط' : 'غير نشط'),
        _buildDetailItem(
          'تاريخ الإنشاء',
          admin.createdAt.toString().split(' ')[0],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).labelMedium(color: Colors.grey),
        Text(value).h6,
        const Divider(),
      ],
    ).pb4;
  }
}
