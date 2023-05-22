import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/apis/supabase_creds.dart';

import 'package:haba/src/features/authentication/bloc/app_auth_bloc.dart';
import 'package:haba/src/pages/user_auth_page.dart';
import 'package:haba/src/utils/show_snackbar.dart';

import 'package:haba/src/widgets/profile_edit.dart';
//import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//import '../utils/secure_local_storage.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String name = "";
  String? _avatarUrl;
  var _loading = false;

  String _latitude = "";
  String _longitude = "";
  //List<LatLng> recentLocations = [_longitude, _latitude];

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });
    try {
      final userId = SupabaseCredentials.supabase.auth.currentUser!.id;
      final data = await SupabaseCredentials.supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single() as Map;
          name = (data['username'] ?? "") as String;
          _avatarUrl = (data['avatar_url'] ?? "") as String;
          _latitude = (data['latitude'] ?? "") as String;
          _longitude = (data['longitude'] ?? "") as String;
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (e) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred!');
    }
    setState(() {
      _loading = false;
    });
  }

  // Future<void> returnFutureStr() async {
  //   Future<String> futureStr = Future.value(await SecureLocalStorage().readSecureData('username'));
  //   String res = await futureStr;
  //   setState(() {
  //     name = res;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getProfile();
  //  returnFutureStr();
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
            //const Center(child: Icon(Icons.account_circle_rounded, size: 68,)),
            //
             Center(
               child: _avatarUrl == null || _avatarUrl == "" ?
               const Icon(Icons.account_circle_rounded, size: 120,) :
               Image.network(
                 _avatarUrl!,
                  width: 120,
                 height: 120,
                 fit: BoxFit.cover,
               ),
             ),
            const SizedBox(height: 18),
            ListTile(
              leading: const Icon(Icons.manage_accounts_rounded),
              title: Text(name.isEmpty ? "Set account" : "$name's account"),
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
             //  SecureLocalStorage().deleteSecureData('username');
              },
            ),
          ],
        ),
      ),
    );
  }
}
