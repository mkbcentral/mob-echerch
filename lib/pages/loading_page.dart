import 'package:echurch/controller/user_controller.dart';
import 'package:echurch/pages/auth/login_page.dart';
import 'package:echurch/pages/home_page.dart';
import 'package:echurch/pages/ui/basics/basic_ui.dart';
import 'package:echurch/services/api_constant.dart';
import 'package:echurch/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void _loadingInfo() async {
    String token = await getToken();
    if (token == '') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      ApiResponse response = await getUserDetail();
      print("Errrot ${response.error}");
      if (response.error == null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else if (response.error == unauthorized) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, '${response.error}');
      }
    }
  }

  @override
  void initState() {
    _loadingInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
