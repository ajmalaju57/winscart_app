// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:winscart/utils/color.dart';

class AudioBubble extends StatefulWidget {
  const AudioBubble({Key? key, required this.filepath}) : super(key: key);

  final String filepath;

  @override
  State<AudioBubble> createState() => _AudioBubbleState();
}

class _AudioBubbleState extends State<AudioBubble> {
  final player = AudioPlayer();
  Duration? duration;

  @override
  void initState() {
    super.initState();
    player.setFilePath(widget.filepath).then((value) {
      setState(() {
        duration = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            height: 45,
            padding: const EdgeInsets.only(left: 12, right: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30 - 10),
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return GestureDetector(
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            onTap: player.play,
                          );
                        } else if (playing != true) {
                          return GestureDetector(
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            onTap: player.play,
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return GestureDetector(
                            child: const Icon(
                              Icons.pause,
                              color: Colors.black,
                            ),
                            onTap: player.pause,
                          );
                        } else {
                          return GestureDetector(
                            child: const Icon(
                              Icons.replay,
                              color: Colors.black,
                            ),
                            onTap: () {
                              player.seek(Duration.zero);
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StreamBuilder<Duration>(
                        stream: player.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  color: Colors.black,
                                  value: snapshot.data!.inMilliseconds /
                                      (duration?.inMilliseconds ?? 1),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      prettyDuration(
                                          snapshot.data! == Duration.zero
                                              ? duration ?? Duration.zero
                                              : snapshot.data!),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text(
                                      "M4A",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const LinearProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String prettyDuration(Duration d) {
    var min = d.inMinutes < 10 ? "0${d.inMinutes}" : d.inMinutes.toString();
    var sec = d.inSeconds < 10 ? "0${d.inSeconds}" : d.inSeconds.toString();
    return min + ":" + sec;
  }
}
