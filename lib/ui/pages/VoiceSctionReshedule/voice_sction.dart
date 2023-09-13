// ignore_for_file: prefer_interpolation_to_compose_strings, sort_child_properties_last, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/ui/pages/VoiceSctionReshedule/audio_bubble.dart';
import 'package:winscart/utils/color.dart';
import 'package:winscart/utils/extensions/space_ext.dart';
import 'package:winscart/utils/helpers/helper_dialog.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';
import 'package:winscart/utils/helpers/page_helpers.dart';

TextEditingController audioFileReshedule = TextEditingController();

class VoiceSctionReshedule extends StatefulWidget {
  const VoiceSctionReshedule({
    super.key,
  });

  @override
  State<VoiceSctionReshedule> createState() => _VoiceSctionResheduleState();
}

class _VoiceSctionResheduleState extends State<VoiceSctionReshedule> {
  static const double size = 40;
  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";
  late Record record;
  String documentPath = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                child: const Icon(Icons.mic, color: Colors.black),
                height: size,
                width: size,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
              ),
              onTap: audioFileReshedule.text.isNotEmpty
                  ? () {
                      snackBar(context,
                          message: "Already Recorded Voice",
                          type: MessageType.error);
                    }
                  : () async {
                      debugPrint("onLongPress");
                      Future<bool> requestPermission() async {
                        // Replace 'Permission.camera' with the permission you need (e.g., Permission.microphone)
                        final status = await Record().hasPermission();
                        return status; // Return true if permission is granted, false otherwise
                      }

                      try {
                        // Request the permission and wait for the result
                        bool isPermissionGranted = await requestPermission();

                        if (isPermissionGranted == true) {
                          debugPrint("Permission granted!");
                          // Perform the action that requires the permission (e.g., access the camera)
                          showPopup(
                            context,
                            barrierDismissible: false,
                            content: WillPopScope(
                              onWillPop: () async {
                                return false;
                              },
                              child: Container(
                                height: 300,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Lottie.asset(
                                      'assets/animation_lkurrkif.json',
                                      height: 200,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Vibrate.feedback(
                                              FeedbackType.success);

                                          timer?.cancel();
                                          timer = null;
                                          startTime = null;
                                          recordDuration = "00:00";

                                          final filePath =
                                              await Record().stop();
                                          setState(() {
                                            audioFileReshedule.text =
                                                filePath.toString();
                                          });
                                          debugPrint(filePath);
                                          Screen.closeDialog(context);
                                        },
                                        child: const AppText("Submit"))
                                  ],
                                ),
                              ),
                            ),
                          );

                          Vibrate.feedback(FeedbackType.success);

                          record = Record();
                          documentPath =
                              (await getApplicationDocumentsDirectory()).path +
                                  "/";
                          await record.start(
                            path: documentPath +
                                "audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
                            encoder: AudioEncoder.AAC,
                            bitRate: 128000,
                            samplingRate: 44100,
                          );
                          startTime = DateTime.now();
                          timer =
                              Timer.periodic(const Duration(seconds: 1), (_) {
                            final minDur =
                                DateTime.now().difference(startTime!).inMinutes;
                            final secDur = DateTime.now()
                                    .difference(startTime!)
                                    .inSeconds %
                                60;
                            String min =
                                minDur < 10 ? "0$minDur" : minDur.toString();
                            String sec =
                                secDur < 10 ? "0$secDur" : secDur.toString();
                            recordDuration = "$min:$sec";
                            // debugPrint(recordDuration);
                          });
                        } else {
                          snackBar(context,
                              message: "Permission denied",
                              type: MessageType.error);
                          // Handle the case when the user denies the permission or it's restricted by the system
                        }
                      } catch (e) {
                        debugPrint("Error while requesting permission: $e");
                        snackBar(context,
                            message: "Permission denied",
                            type: MessageType.error);
                        await requestPermission();
                        // Handle any other exceptions that might occur during permission handling
                      }
                    },
            ),
            15.wBox,
            audioFileReshedule.text.isEmpty
                ? 0.hBox
                : Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: AudioBubble(filepath: audioFileReshedule.text),
                      ),
                      10.wBox,
                      GestureDetector(
                          onTap: () {
                            debugPrint("df");
                            setState(() {
                              audioFileReshedule.text = "";
                            });
                          },
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            size: 30,
                            color: Colors.black,
                          ))
                    ],
                  )
          ],
        ),
      ],
    );
  }
}
