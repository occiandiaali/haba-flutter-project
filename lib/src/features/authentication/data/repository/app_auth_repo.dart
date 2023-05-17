import 'package:flutter/material.dart';
import 'package:haba/src/apis/supabase_creds.dart';

//import 'package:supabase/supabase.dart';

class AppAuthRepo {
 // final client = SupabaseCredentials.supabaseClient;
  final client = SupabaseCredentials.supabase;

  Future<void> registerUser({required String email, required String password}) async {
    debugPrint("email: $email - password: $password");
    await client.auth.signUp(
      email: email,
      password: password,
    );
    // final AuthResponse res = await client.auth.signUp(
    //     email: email,
    //     password: password,
    // );
    // debugPrint("Reg user: ${res.user}");
    // debugPrint("Reg session: ${res.session}");
    // res;
  }

  Future<void> signInWithEmail({required String email, required String password}) async {
    await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    // final AuthResponse res = await client.auth.signInWithPassword(
    //     email: email,
    //     password: password,
    // );
    // debugPrint("login res: $res");
    // res;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

}
