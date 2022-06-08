import 'package:audioplayers/audioplayers.dart';
import 'package:echurch/controller/chiurch_controller.dart';
import 'package:echurch/models/Church.dart';
import 'package:echurch/models/Preaching.dart';
import 'package:echurch/pages/church/church_page.dart';
import 'package:echurch/pages/ui/basics/basic_ui.dart';
import 'package:echurch/pages/ui/componets/custom_music_list.dart';
import 'package:echurch/services/api_response.dart';
import 'package:flutter/material.dart';

class PreachingPage extends StatefulWidget {
  final Church? church;
  const PreachingPage({Key? key, this.church}) : super(key: key);

  @override
  State<PreachingPage> createState() => _PreachingPageState();
}

class _PreachingPageState extends State<PreachingPage> {
  List<dynamic> preachingList = [];
  bool isLoading = true;
  String currentSinger = "";
  String currentTitle = "";
  String currentAudioUrl = "";

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  IconData iconBtn = Icons.play_arrow;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  bool isSelected = false;
  String currentSong = "";
  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    }
  }

  Future<void> retreavePreachings() async {
    ApiResponse response =
        await getPreaching(int.parse(widget.church!.id.toString()));
    if (response.error == null) {
      setState(() {
        preachingList = response.data as List<dynamic>;
        isLoading = isLoading ? !isLoading : isLoading;
      });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, '${response.error}');
    }
  }

  @override
  void initState() {
    retreavePreachings();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.PLAYING;
      });

      audioPlayer.onDurationChanged.listen((newDuratio) {
        setState(() {
          duration = newDuratio;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.church!.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            audioPlayer.dispose();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChurchPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: preachingList.length,
                    itemBuilder: (context, index) {
                      Preaching preaching = preachingList[index];

                      if (index == 0) {
                        currentSinger = preaching.predicator_name!;
                        currentTitle = preaching.title!;
                      }
                      return musicListCustom(
                          onTap: () {
                            setState(() {
                              currentSinger = preaching.predicator_name!;
                              currentTitle = preaching.title!;
                              audioPlayer.stop();
                            });
                          },
                          onPressedPlay: () {
                            playMusic(preaching.audio_file_url!);
                          },
                          title: '${preaching.title}',
                          pastor_name: '${preaching.predicator_name}',
                          audio_url: '${preaching.audio_file_url}',
                          isPlayed: isPlaying);
                    }),
          ),
          Card(
            elevation: 6,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Slider.adaptive(
                      value: position.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      min: 0,
                      onChanged: (value) async {
                        final pos = Duration(seconds: value.toInt());
                        await audioPlayer.seek(pos);
                        await audioPlayer.resume();
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(duration - position)),
                        Text(formatDuration(duration)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/earphone.jpg"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(currentSinger,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(currentTitle,
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (isPlaying) {
                              audioPlayer.pause();
                              setState(() {
                                iconBtn = Icons.pause;
                                isPlaying = false;
                              });
                            } else {
                              audioPlayer.resume();
                              setState(() {
                                iconBtn = Icons.play_arrow;
                                isPlaying = true;
                              });
                            }
                          },
                          icon: Icon(
                            iconBtn,
                            size: 50,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
