import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class ChurchPage extends StatefulWidget {
  const ChurchPage({Key? key}) : super(key: key);

  @override
  State<ChurchPage> createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: const Center(
            child: Text("Church",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))));
  }

  _appBar() {
    return AppBar(
      title: const Text("EGLISES"),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeService().swichMode();
          });
        },
        child: Icon(Get.isDarkMode ? Icons.light_mode : Icons.nightlight_round),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
    );
  }
}
