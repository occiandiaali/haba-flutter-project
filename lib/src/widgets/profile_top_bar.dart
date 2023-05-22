
import 'package:flutter/material.dart';
import 'package:haba/src/utils/show_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../apis/supabase_creds.dart';

class ProfileTopBar extends StatefulWidget {

  final VoidCallback open;

  const ProfileTopBar({Key? key, required this.open})
      : super(key: key);

  @override
  State<ProfileTopBar> createState() => _ProfileTopBarState();
}

class _ProfileTopBarState extends State<ProfileTopBar> {

  late String username = "user";
  late String avatarUrl = "";

  Future<void> getProfile() async {
    try {
      final userId = SupabaseCredentials.supabase.auth.currentUser!.id;
      final data = await SupabaseCredentials.supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single() as Map;
      username = (data['username'] ?? "") as String;
      avatarUrl = (data['avatar_url'] ?? "") as String;
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (e) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred!');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.open,
          child: Container(
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(50)
            ),
            child: avatarUrl.isEmpty ?
            const Icon(
              Icons.account_circle_rounded,
              size: 56,
            ) : ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                avatarUrl,
                width: 56,
                height: 56,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
            color: Colors.black26.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(username.isEmpty ? "username" : "Hi, $username",
              overflow: TextOverflow.fade, // TODO: Handle this
              style: const TextStyle(
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
