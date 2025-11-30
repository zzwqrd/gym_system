import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../list/data/model/model.dart';
import '../controller/controller.dart';
import '../controller/state.dart';

class UserDetailsView extends StatefulWidget {
  final int userId;
  final User? user; // Optional: pass object directly if available

  const UserDetailsView({super.key, required this.userId, this.user});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      context.read<UserDetailsController>().getUserById(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تفاصيل المشترك')),
        body: widget.user != null
            ? _buildContent(widget.user!)
            : BlocBuilder<UserDetailsController, UserDetailsState>(
                builder: (context, state) {
                  if (state.requestState == RequestState.loading) {
                    return const CircularProgressIndicator().center;
                  } else if (state.requestState == RequestState.error) {
                    return Text(state.errorMessage).center;
                  } else if (state.data == null) {
                    return const Text('لا توجد بيانات').center;
                  }
                  return _buildContent(state.data! as User);
                },
              ),
      ),
    );
  }

  Widget _buildContent(User user) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 32),
          ),
        ).center.pb6,
        _buildDetailItem('الاسم', user.name),
        _buildDetailItem('البريد الإلكتروني', user.email),
        _buildDetailItem('رقم الهاتف', user.phone),
        if (user.nationalId != null)
          _buildDetailItem('رقم الهوية', user.nationalId!),
        _buildDetailItem('الحالة', user.isActive ? 'نشط' : 'غير نشط'),
        _buildDetailItem(
          'تاريخ الإنشاء',
          user.createdAt.toString().split(' ')[0],
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
