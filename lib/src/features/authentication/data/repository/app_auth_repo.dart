import 'package:flutter/material.dart';
import 'package:haba/src/apis/supabase_creds.dart';

class AppAuthRepo {

  final client = SupabaseCredentials.supabase;

  Future<void> registerUser({required String email, required String password}) async {
    debugPrint("email: $email - password: $password");
    await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmail({required String email, required String password}) async {
    await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

}
