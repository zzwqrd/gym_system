import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/style_extensions_mor.dart';

import '../../../../di/service_locator.dart';
import 'get_data_user_cubit.dart';

@visibleForTesting
class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = sl<GetDataUserCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: BlocBuilder<GetDataUserCubit, GetDataUserState>(
        bloc: bloc,
        builder: (context, state) {
          return TextButton(
            onPressed: () {
              bloc.loginAdmin("admin@admin.com", "1234567");
            },
            child: 'Details'.h1(),
          );
          // switch (state) {
          //   case GetDataUserInitial():
          //     return Center(child: Text('Please wait...'));
          //   case GetDataUserLoading():
          //     return Center(child: CircularProgressIndicator());
          //   case GetDataUserError(:final message):
          //     return Center(child: Text('Error: $message'));
          //   case GetDataUserLoaded(:final users):
          //     return ListView.builder(
          //       itemCount: users.length,
          //       itemBuilder: (context, index) {
          //         final user = users[index];
          //         return Column(
          //           children: [
          //             // ListTile(
          //             //   leading: CircleAvatar(
          //             //     child: Text(user.username[0].toUpperCase()),
          //             //   ),
          //             //   title: Text(user.fullName),
          //             //   subtitle: Text(user.email),
          //             //   trailing: user.isActive
          //             //       ? Icon(Icons.check_circle, color: Colors.green)
          //             //       : Icon(Icons.cancel, color: Colors.red),
          //             // ),
          //             Divider(),
          //             TextButton(
          //               onPressed: () {
          //                 bloc.loginAdmin("admin@admin.com", "1234567");
          //               },
          //               child: Text('Details'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          // }
          // return Center(child: Text('No data'));
        },
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const CircularProgressIndicator(),
    //         const SizedBox(height: 20),
    //         Text(
    //           'Loading...',
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
