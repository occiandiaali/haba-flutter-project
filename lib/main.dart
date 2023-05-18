import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/apis/supabase_creds.dart';
import 'package:haba/src/features/authentication/bloc/app_auth_bloc.dart';
import 'package:haba/src/features/authentication/data/repository/app_auth_repo.dart';

import 'package:haba/src/pages/haba_splash.dart';
import 'package:haba/src/pages/home_page.dart';
import 'package:haba/src/pages/splash_page.dart';

import 'package:haba/src/pages/user_auth_page.dart';
import 'package:haba/src/utils/show_snackbar.dart';

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
          home: const SplashPage(),
        ),
      ),
    );
  }
}

class HabaApp extends StatefulWidget {
  const HabaApp({Key? key}) : super(key: key);

  @override
  State<HabaApp> createState() => _HabaAppState();
}

class _HabaAppState extends State<HabaApp> {

  @override
  void initState() {
    super.initState();
    try {
      SupabaseCredentials.supabase.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        if (event == AuthChangeEvent.signedIn) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const HomePage()), (route) => false);
        } else if (event == AuthChangeEvent.signedOut) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const UserAuthPage()), (route) => false);
        }
      });
    } catch (e) {
      showSnackBar(message: e.toString(), context: context, backgroundColor: Colors.red);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserAuthPage()));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const HabaSplash();
  }
}

