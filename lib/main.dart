import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/apis/supabase_creds.dart';
import 'package:haba/src/features/authentication/bloc/app_auth_bloc.dart';
import 'package:haba/src/features/authentication/data/repository/app_auth_repo.dart';

import 'package:haba/src/pages/user_auth_page.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  // Future<bool> isConnected = checkConnection();
  await Supabase.initialize(
      url: SupabaseCredentials.url,
      anonKey: SupabaseCredentials.key);

  // isConnected ? await Supabase.initialize(
  //     url: SupabaseCredentials.url,
  //     anonKey: SupabaseCredentials.key) : const ScaffoldMessenger(child: SnackBar(content: Text("No internet connection found"),));

 // runApp(const HabaApp());
  runApp(const CompleteApp());
}

class CompleteApp extends StatelessWidget {
  const CompleteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppAuthRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppAuthBloc>(
            create: (context) => AppAuthBloc(
                authRepo: RepositoryProvider.of<AppAuthRepo>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'haba',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: const UserAuthPage(),
        ),
      ),
    );
  }
}
