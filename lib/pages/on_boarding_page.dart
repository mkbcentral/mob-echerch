import 'package:echurch/pages/loading_page.dart';
import 'package:echurch/pages/ui/componets/buil_onboarding_view_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = Size.fromHeight(80);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildOnboardingViewPage(
                color: Colors.green.shade100,
                urlImage: "assets/images/ig4.jpg",
                title: "PREDICATIONS",
                subTilte:
                    "Mais soyez transformés par le renouvellement de l'intelligence, afin que vous discerniez quelle est la volonté de Dieu...Romains 12:2"),
            buildOnboardingViewPage(
                color: Colors.teal.shade100,
                urlImage: "assets/images/ig8.jpg",
                title: "EVENEMENTS",
                subTilte:
                    "Car là où deux ou trois sont assemblés en mon nom, je suis au milieu d'eux. Matthieu 18:20"),
            buildOnboardingViewPage(
                color: Colors.blue.shade100,
                urlImage: "assets/images/ig12.jpg",
                title: "MUSICS",
                subTilte:
                    "Car ta bonté vaut mieux que la vie. Mes lèvres célèbrent tes louanges.Ainsi je te bénirai toute ma vie,je lèverai mes mains en faisant appel à toi. Psaume 63:4-5"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.blue.shade500,
                  minimumSize: size),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                    // ignore: unrelated_type_equality_checks
                    MaterialPageRoute(
                        // ignore: unrelated_type_equality_checks
                        builder: (context) => const LoadingPage()));
              },
              child: const Text(
                "Lancez-vous",
                style: TextStyle(fontSize: 25),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text("SKIP")),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.teal.shade700),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text("NEXT"))
                ],
              ),
            ),
    );
  }
}
