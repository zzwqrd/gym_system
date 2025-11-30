import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../list/data/model/model.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class AdminDetailsView extends StatefulWidget {
  final int adminId;
  final Admin? admin; // Optional: pass object directly if available

  const AdminDetailsView({super.key, required this.adminId, this.admin});

  @override
  State<AdminDetailsView> createState() => _AdminDetailsViewState();
}

class _AdminDetailsViewState extends State<AdminDetailsView> {
  @override
  void initState() {
    super.initState();
    if (widget.admin == null) {
      context.read<AdminDetailsController>().getAdminById(widget.adminId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDetailsController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تفاصيل المسؤول')),
        body: widget.admin != null
            ? _buildContent(widget.admin!)
            : BlocBuilder<AdminDetailsController, AdminDetailsState>(
                builder: (context, state) {
                  if (state.requestState == RequestState.loading) {
                    return const CircularProgressIndicator().center;
                  } else if (state.requestState == RequestState.error) {
                    return Text(state.errorMessage).center;
                  } else if (state.data == null) {
                    return const Text('لا توجد بيانات').center;
                  }
                  return _buildContent(state.data! as Admin);
                },
              ),
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
