import 'package:echurch/controller/chiurch_controller.dart';
import 'package:echurch/models/Church.dart';
import 'package:echurch/pages/church/preachin_page.dart';
import 'package:echurch/pages/ui/basics/basic_ui.dart';
import 'package:echurch/pages/ui/componets/custom_list_church.dart';
import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:echurch/services/api_response.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class ChurchPage extends StatefulWidget {
  const ChurchPage({Key? key}) : super(key: key);

  @override
  State<ChurchPage> createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  List<dynamic> churchList = [];
  bool isLoading = true;
  Future<void> retreaveChurches() async {
    ApiResponse response = await getChurch();
    if (response.error == null) {
      setState(() {
        churchList = response.data as List<dynamic>;
        isLoading = isLoading ? !isLoading : isLoading;
      });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, '${response.error}');
    }
  }

  @override
  void initState() {
    retreaveChurches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: retreaveChurches,
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: churchList.length,
              itemBuilder: (context, index) {
                Church church = churchList[index];
                return churchListCustom(
                    name: '${church.name}',
                    pastorName: '${church.pastor_name}',
                    logo_url: '${church.logo_url}',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          // ignore: unrelated_type_equality_checks
                          MaterialPageRoute(
                              // ignore: unrelated_type_equality_checks
                              builder: (context) =>
                                  PreachingPage(church: church)));
                    });
              }),
        ));
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
