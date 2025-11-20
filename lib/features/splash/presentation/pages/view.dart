import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_data_user_cubit.dart';

@visibleForTesting
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataUserCubit()..getAllUsers(),
      child: Scaffold(
        appBar: AppBar(title: Text('Users')),
        body: BlocBuilder<GetDataUserCubit, GetDataUserState>(
          builder: (context, state) {
            if (state is GetDataUserLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is GetDataUserError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is GetDataUserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user.username[0].toUpperCase()),
                    ),
                    title: Text(user.fullName),
                    subtitle: Text(user.email),
                    trailing: user.isActive
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.cancel, color: Colors.red),
                  );
                },
              );
            }

            return Center(child: Text('No data'));
          },
        ),
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
