import 'package:cached_network_image/cached_network_image.dart';
import 'package:echurch/controller/chiurch_controller.dart';
import 'package:echurch/controller/user_controller.dart';
import 'package:echurch/models/ChurchEvent.dart';
import 'package:echurch/pages/auth/login_page.dart';
import 'package:echurch/pages/ui/basics/basic_ui.dart';
import 'package:echurch/pages/ui/componets/buil_like_event.dart';
import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:echurch/services/api_constant.dart';
import 'package:echurch/services/api_response.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<dynamic> eventList = [];
  bool _isLoading = true;
  Future<void> _retreaveEvents() async {
    ApiResponse response = await getEvents();
    if (response.error == null) {
      setState(() {
        eventList = response.data as List<dynamic>;
        _isLoading = _isLoading ? !_isLoading : _isLoading;
      });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, '${response.error}');
    }
  }

  Future<void> _handleLike(int eventId) async {
    final response = await likeAndDislikeEvent(eventId);
    if (response.error == null) {
      _retreaveEvents();
      // ignore: use_build_context_synchronously
      showSnackBar(context, response.data.toString());
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, response.error.toString());
    }
  }

  @override
  void initState() {
    _retreaveEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: () {
            return _retreaveEvents();
          },
          child: ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                ChurchEvent event = eventList[index];
                return Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 38.0,
                                      height: 38.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    imageUrl: event.church!.logo_url == ""
                                        ? defaulImageURL
                                        : "${baseAssetURL}storage/${event.church!.logo_url!}",
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        FadeShimmer.round(
                                      size: 38,
                                      fadeTheme: Get.isDarkMode
                                          ? FadeTheme.dark
                                          : FadeTheme.dark,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    event.church!.abreviation == ""
                                        ? event.church!.name!.length > 20
                                            ? '${event.church!.name!.substring(0, 20)}...'
                                            : event.church!.name!
                                        : event.church!.abreviation!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.more_vert),
                              ),
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "detail",
                                  child: Text("Detail"),
                                )
                              ],
                              onSelected: (val) => {
                                if (val == "detail")
                                  {showSnackBar(context, "Deatil")}
                                else
                                  {}
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${event.title}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 180.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          imageUrl: event.cover_event_url! == ""
                              ? defaulImageURL
                              : event.cover_event_url!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => FadeShimmer(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            radius: 4,
                            fadeTheme: Get.isDarkMode
                                ? FadeTheme.dark
                                : FadeTheme.dark,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Debut: ${event.started_at_date} "),
                              Text("à ${event.started_at_time}")
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            builLikeEventCustom(
                                event.likes_count ?? 0,
                                // ignore: unrelated_type_equality_checks
                                event.isSelfLike == true
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                // ignore: unrelated_type_equality_checks
                                event.isSelfLike == true
                                    ? Colors.red
                                    : Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black, () {
                              _handleLike(event.id ?? 0);
                            }),
                            Container(
                              height: 25,
                              width: 0.5,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : const Color.fromARGB(96, 25, 25, 25),
                            ),
                            builLikeEventCustom(
                                event.comments_count ?? 0,
                                Icons.sms_outlined,
                                Get.isDarkMode ? Colors.white : Colors.black,
                                () {})
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  _appBar() {
    return AppBar(
      title: const Text("EVENEMENTS"),
      centerTitle: true,
      flexibleSpace: showGardientbg(),
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
