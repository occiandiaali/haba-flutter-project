import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:haba/src/features/authentication/bloc/app_auth_bloc.dart';
import 'package:haba/src/pages/user_auth_page.dart';
import 'package:haba/src/widgets/profile_edit.dart';

import '../utils/secure_local_storage.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String name = "";

  Future<void> returnFutureStr() async {
    Future<String> futureStr = Future.value(await SecureLocalStorage().readSecureData('username'));
    String res = await futureStr;
    setState(() {
      name = res;
    });
  }

  @override
  void initState() {
    super.initState();
    returnFutureStr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppAuthBloc, AppAuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const UserAuthPage()),
                    (route) => false);
          }
        },
        child: ListView(
          physics: const ScrollPhysics(),
          children: [
            const SizedBox(height: 18),
            const Center(child: Icon(Icons.account_circle_rounded, size: 68,)),
            const SizedBox(height: 18),
            ListTile(
              leading: const Icon(Icons.manage_accounts_rounded),
              title: Text("$name's account"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileEdit())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProfileEdit())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_rounded),
              title: const Text('Chats'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group_rounded),
              title: const Text('Friends'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.my_location_rounded),
              title: const Text('Recent locations'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_suggest_rounded),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline_rounded),
              title: const Text('Help'),
              onTap: () {},
            ),
            const Divider(height: 18,),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: () {
               context.read<AppAuthBloc>().add(SignOutRequested());
               SecureLocalStorage().deleteSecureData('username');
              },
            ),
          ],
        ),
      ),
    );
  }
}
