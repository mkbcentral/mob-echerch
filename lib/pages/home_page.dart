import 'package:echurch/pages/church/church_page.dart';
import 'package:echurch/pages/events/event_page.dart';
import 'package:echurch/pages/music/music_page.dart';
import 'package:echurch/pages/profile/profile_page.dart';
import 'package:echurch/pages/ui/basics/notification_service.dart';
import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  int index = 0;

  final scrrens = [
    const ChurchPage(),
    const EventPage(),
    const MusicPage(),
    const ProfilePage()
  ];
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotificatio();
    print(Get.isDarkMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrrens[index],
      bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 3),
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.church_outlined),
              label: "Eglises",
              selectedIcon: Icon(Icons.church),
            ),
            NavigationDestination(
              icon: Icon(Icons.event),
              label: "Evenements",
              selectedIcon: Icon(Icons.event_note_rounded),
            ),
            NavigationDestination(
              icon: Icon(Icons.music_note_outlined),
              label: "Musics",
              selectedIcon: Icon(Icons.music_note),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: "Profile",
              selectedIcon: Icon(Icons.person),
            )
          ]),
    );
  }
}
