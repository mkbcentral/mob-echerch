import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

Widget musicListCustom({
  required String title,
  required String pastor_name,
  required String audio_url,
  required bool isPlayed,
  onTap,
  onPressedPlay,
  onPressedDownload,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          isPlayed
              ? const MiniMusicVisualizer(
                  color: Colors.red,
                  width: 7,
                  height: 15,
                )
              : Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 145, 247, 247),
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/earphone.jpg"))),
                ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pastor_name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: onPressedPlay,
                              icon: const Icon(
                                Icons.play_circle,
                                size: 25,
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          IconButton(
                              onPressed: onPressedDownload,
                              icon: const Icon(
                                Icons.download,
                                size: 25,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
