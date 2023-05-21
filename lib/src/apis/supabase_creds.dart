import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCredentials {
  static const String url = "https://pjmhqrwjtyywvsodofxe.supabase.co";
  static const String key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBqbWhxcndqdHl5d3Zzb2RvZnhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQxNjg3OTksImV4cCI6MTk5OTc0NDc5OX0.emH9WBQifOxoTvA96Ul6tZyOXG6_TAKxPkkblpF6aCE";

 // static SupabaseClient supabaseClient = SupabaseClient(url, key);
  static final supabase = Supabase.instance.client;
}
