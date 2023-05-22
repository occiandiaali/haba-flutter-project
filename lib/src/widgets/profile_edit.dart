import 'package:flutter/material.dart';
import 'package:haba/src/apis/supabase_creds.dart';
import 'package:haba/src/utils/show_snackbar.dart';
import 'package:haba/src/widgets/avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _usernameController = TextEditingController();
  // final _oldSecretController = TextEditingController();
  // final _newSecretController = TextEditingController();
  // bool hideOldPassword = true;
  // bool hideNewPassword = true;
  String? _avatarUrl;
  var _loading = false;


  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text.trim();
    final user = SupabaseCredentials.supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await SupabaseCredentials.supabase.from('profiles').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: 'Profile updated!');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (e) {
      context.showErrorSnackBar(message: 'Unexpected error occurred. That is all I know!');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = SupabaseCredentials.supabase.auth.currentUser!.id;
      await SupabaseCredentials.supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      if (mounted) {
        context.showSnackBar(message: 'Updated your profile image!');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error has occurred');
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Avatar(
                  imageUrl: _avatarUrl,
                  onUpload: _onUpload),
              const SizedBox(height: 10),
              TextField(
                autofocus: true,
                controller: _usernameController,
                decoration: const InputDecoration(
                  label: Text('User Name'),
                  border: OutlineInputBorder(),
                ),
              ),
             // const SizedBox(height: 10,),
              // TextFormField(
              //   keyboardType: TextInputType.visiblePassword,
              //   controller: _oldSecretController,
              //   obscureText: hideOldPassword,
              //   obscuringCharacter: '=',
              //   decoration: InputDecoration(
              //       suffixIcon: IconButton(
              //         padding: const EdgeInsetsDirectional.only(end: 12.0),
              //         onPressed: () {
              //           if (hideOldPassword == true) {
              //             setState(() {
              //               hideOldPassword = false;
              //             });
              //           } else {
              //             setState(() {
              //               hideOldPassword = true;
              //             });
              //           }
              //         },
              //         icon: Icon(
              //           hideOldPassword ?
              //           Icons.visibility_off_rounded : Icons.visibility,
              //           color: Colors.teal,
              //         ),
              //       ),
              //       hintText: "Old Password",
              //       border: const OutlineInputBorder()
              //   ),
              //   autovalidateMode:
              //   AutovalidateMode.onUserInteraction,
              //   validator: (value) {
              //     return value != null &&
              //         value.length < 6 ?
              //     "Enter minimum of 6 characters" : null;
              //   },
              // ),
              // const SizedBox(height: 10,),
              // TextFormField(
              //   keyboardType: TextInputType.visiblePassword,
              //   controller: _newSecretController,
              //   obscureText: hideNewPassword,
              //   obscuringCharacter: '=',
              //   decoration: InputDecoration(
              //       suffixIcon: IconButton(
              //         padding: const EdgeInsetsDirectional.only(end: 12.0),
              //         onPressed: () {
              //           if (hideNewPassword == true) {
              //             setState(() {
              //               hideNewPassword = false;
              //             });
              //           } else {
              //             setState(() {
              //               hideNewPassword = true;
              //             });
              //           }
              //         },
              //         icon: Icon(
              //           hideNewPassword ?
              //           Icons.visibility_off_rounded : Icons.visibility,
              //           color: Colors.teal,
              //         ),
              //       ),
              //       hintText: "New Password",
              //       border: const OutlineInputBorder()
              //   ),
              //   autovalidateMode:
              //   AutovalidateMode.onUserInteraction,
              //   validator: (String? value) {
              //     String res = '';
              //     if (value!.isEmpty || value == _oldSecretController.text || value.length < 6) {
              //       res = 'You must enter a new password that is at least 6 characters, and different from old one!';
              //     }
              //     return res;
              //   },
              // ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.remove_red_eye_outlined, size: 36, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.do_disturb_on_outlined, size: 36, color: Colors.white,),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.sync, size: 36, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                 // Row(),
                ],
              ),
              const SizedBox(height: 25),
              TextButton.icon(
                icon: const Icon(Icons.update_rounded),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 50
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  _updateProfile();
                //  Navigator.pop(context);
                },
                label: Text(_loading ? 'Saving...' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
