//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:haba/src/features/geolocation/presentation/map_view.dart';

//import 'package:haba/src/utils/secure_local_storage.dart';
//import 'package:haba/src/utils/show_snackbar.dart';
import 'package:haba/src/widgets/profile_top_bar.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

//import '../apis/supabase_creds.dart';
import '../utils/map_info_dialogue.dart';
import '../utils/modalBottomSheet.dart';
import '../widgets/expandable_fab.dart';
import '../widgets/expandable_fab_action_button.dart';
import '../widgets/profile_settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: SizedBox(

              child: MapView()
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: ProfileTopBar(open: () => modalBottomSheet(
                  context,
                  const ProfileSettings()),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 48.0, bottom: 32.0),
        child: ExpandableFab(
          distance: 120.0,
          children: [
            ExpandableFabActionButton(
              onPressed: () {
                mapInfoDialog(context);
              },
              icon: const Icon(Icons.info_outline_rounded),
            ),
            ExpandableFabActionButton(
              onPressed: () {},
              icon: const Icon(Icons.zoom_in_map_rounded),
            ),
            ExpandableFabActionButton(
              onPressed: () {},
              icon: const Icon(Icons.social_distance_rounded),
            ),
            ExpandableFabActionButton(
              onPressed: () {},
              icon: const Icon(Icons.crisis_alert),
            ),
          ],),
      ),
    );
  }
}
