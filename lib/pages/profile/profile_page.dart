import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: const Center(
            child: Text("Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))));
  }

  _appBar() {
    return AppBar(
      title: const Text("EVENEMENTS"),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeService().swichMode();
          });
        },
        child: Icon(Get.isDarkMode ? Icons.light_mode : Icons.nightlight_round),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
      ],
    );
  }
}
