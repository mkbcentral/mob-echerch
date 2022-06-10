import 'package:echurch/controller/user_controller.dart';
import 'package:echurch/models/user.dart';
import 'package:echurch/pages/auth/register_oage.dart';
import 'package:echurch/pages/home_page.dart';
import 'package:echurch/pages/ui/basics/basic_ui.dart';
import 'package:echurch/pages/ui/componets/buil_form_ui_auth.dart';
import 'package:echurch/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = false;

  void _login() async {
    ApiResponse apiResponse = await loginUser(txtEmail.text, txtPassword.text);
    if (apiResponse.error == null) {
      _saveAndRedirectToHome(apiResponse.data as User);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, '${apiResponse.error}');
      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", user.token ?? '');
    preferences.setInt('userId', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    var borderSide2 = const BorderSide(color: Colors.white);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/ig8.jpg"),
              fit: BoxFit.cover,
              opacity: 80)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.blue.shade800])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Se connecter",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        builTextFormFieldAuth(
                          controler: txtEmail,
                          hintText: "Email",
                          bgColor: Colors.black26,
                          inputType: TextInputType.emailAddress,
                          borderSide: borderSide2,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        builTextFormFieldAuth(
                          isObscureText: true,
                          controler: txtPassword,
                          hintText: "Mot de passe",
                          bgColor: Colors.black26,
                          inputType: TextInputType.visiblePassword,
                          borderSide: borderSide2,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: builElevatedButton(
                                    text: "Se connecter",
                                    bgColor: Colors.blue.shade800,
                                    raduiSize: 30.0,
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = !isLoading;
                                        _login();
                                      });
                                    }),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildLabelTextFormAuth(
                                text: "Vous n'avez un compte ?",
                                txtColor: Colors.white,
                                textSize: 14),
                            builTextButtonFormAuth(
                                text: "S'inscrire",
                                textSize: 14,
                                onPressed: () async {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(
                            child: Text("Ou",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.facebook,
                                  size: 45,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
