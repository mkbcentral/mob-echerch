import 'package:echurch/controller/user_controller.dart';
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
      appBar: _appBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  deleteShowHomePref();
                  logout();
                },
                child: const Text("Logout")),
            const Text(
              "Home page",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeService().swichMode();
            print(Get.isDarkMode);
          });
        },
        child: Icon(Get.isDarkMode ? Icons.light_mode : Icons.nightlight_round),
      ),
      actions: [],
    );
  }
}
