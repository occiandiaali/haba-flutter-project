import 'package:flutter/material.dart';
import 'package:haba/src/widgets/profile_edit.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      children: [
        const SizedBox(height: 18),
        const Center(
          child: Icon(Icons.account_circle_rounded, size: 68,),
        ),
        const SizedBox(height: 18),
        ListTile(
          leading: const Icon(Icons.manage_accounts_rounded),
          title: const Text('Profile'),
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
          leading: const Icon(Icons.lightbulb_sharp),
          title: const Text('Recommendations'),
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
          onTap: () {},
        ),
      ],
    );
  }
}
