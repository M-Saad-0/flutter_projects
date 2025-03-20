import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:my_video_player/widgets/toast_message.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:my_video_player/models/video.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class PlayVideoPage extends StatefulWidget {
  final Video video;
  const PlayVideoPage({super.key, required this.video});

  @override
  State<PlayVideoPage> createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  bool showHud = false;
  late double aspectRatio = 16 / 9;
  // bool isNotSeeking = true;
  late VlcPlayerController controller;
  late String videoEnd;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    controller = VlcPlayerController.file(File(widget.video.path));
    controller.addListener(() {
      if (controller.value.isInitialized) {
        setState(() {
          controller.play();
          aspectRatio = controller.value.aspectRatio;
          videoEnd =
              "${controller.value.duration.inHours.toString().padLeft(2, '0')}:${(controller.value.duration.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}";
        });
      } else {
        controller.initialize();
      }
    });
  }

  Stream<Duration?> get videoPositionStreamStream =>
      Stream.periodic(const Duration(milliseconds: 500), (_) {
        return controller.value.position;
      });

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = controller.value.position;
    final duration = controller.value.duration;
    double progress = (duration.inSeconds > 0)
        ? position.inSeconds / duration.inSeconds
        : 0.0;
    return Scaffold(
        appBar: showHud
            ? AppBar(
                backgroundColor: const Color.fromARGB(141, 0, 0, 0),
                title: Text(
                  controller.dataSource.split("/").last,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : null,
        backgroundColor: Colors.black, // Better for video playback
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showHud = !showHud;
                });
              },
              onHorizontalDragEnd: (v) {
                Duration seekTo = Duration(
                    seconds:
                        position.inSeconds + (v.primaryVelocity! / 50).toInt());
                controller.seekTo(seekTo);
                String message = "";
                if (position.inSeconds > seekTo.inSeconds) {
                  message =
                      "Backward ${-(v.primaryVelocity! / 50).toInt()} seconds";
                } else {
                  message =
                      "Forward ${(v.primaryVelocity! / 50).toInt()} seconds";
                }
                toastMessage(message);
              },
              child: Center(
                child: VlcPlayer(
                  controller: controller,
                  aspectRatio: aspectRatio,
                  placeholder: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: FutureBuilder(
                        future: ScreenBrightness.instance.application,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onVerticalDragUpdate: (v) {
                              double brightnessChange = -v.primaryDelta! / 100;
                              double currentBrightness = snapshot.data!;
                              double newVolume =
                                  (currentBrightness + brightnessChange)
                                      .clamp(0.0, 1.0);

                              ScreenBrightness.instance
                                  .setApplicationScreenBrightness(newVolume);
                            },
                            onDoubleTap: () {
                              final Duration currentDuration =
                                  controller.value.position;
                              if (currentDuration != null) {
                                controller.seekTo(currentDuration -
                                    const Duration(seconds: 10));
                              }
                              toastMessage("-10 seconds");
                            },
                          );
                        })),
                Expanded(child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                    toastMessage(controller.value.isPlaying
                        ? "Video is playing"
                        : "Video is paused");
                  },
                )),
                Expanded(
                    child: FutureBuilder(
                        future: FlutterVolumeController.getVolume(),
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onVerticalDragUpdate: (v) {
                              double volumeChange = -v.primaryDelta! / 100;

                              double currentVolume = snapshot.data ?? 0.0;
                              double newVolume = (currentVolume + volumeChange)
                                  .clamp(0.0, 1.0);
                              FlutterVolumeController.setVolume(newVolume);
                            },
                            onDoubleTap: () {
                              final Duration currentDuration =
                                  controller.value.position;
                              if (currentDuration != null) {
                                controller.seekTo(currentDuration +
                                    const Duration(seconds: 10));
                              }
                              toastMessage("+10 seconds");
                            },
                          );
                        }))
              ],
            ),
            // HUD (controls overlay)
            AnimatedOpacity(
              opacity: showHud ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              child: showHud
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showHud = !showHud;
                        });
                      },
                      child: Container(
                        color: Colors.black54,
                        child: Column(
                          children: [
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "    ${position.inHours.toString().padLeft(2, '0')}:${(position.inMinutes % 60).toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / $videoEnd",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Slider(
                                  onChanged: (value) {
                                    print(
                                        (value * (duration.inSeconds)).toInt());
                                    setState(() {
                                      controller.seekTo(Duration(
                                          seconds: (value * duration.inSeconds)
                                              .toInt()));
                                    });
                                  },
                                  value: progress,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new),
                                      onPressed: () async {
                                        final Duration? currentDuration =
                                            controller.value.position;
                                        if (currentDuration != null) {
                                          controller.seekTo(currentDuration +
                                              const Duration(seconds: 5));
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          controller.value.isPlaying
                                              ? controller.pause()
                                              : controller.play();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios),
                                      onPressed: () {
                                        final Duration? currentDuration =
                                            controller.value.position;
                                        if (currentDuration != null) {
                                          controller.seekTo(currentDuration +
                                              const Duration(seconds: 5));
                                        }
                                      },
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          if (MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft,
                                              DeviceOrientation.landscapeRight
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitUp,
                                              DeviceOrientation.portraitDown
                                            ]);
                                          }
                                        },
                                        icon: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? const Icon(Icons.landscape)
                                            : const Icon(Icons.portrait)),
                                    IconButton(
                                        onPressed: () {
                                          List<double> aspectRatios = [
                                            16 / 9, // Standard widescreen
                                            18 / 9, // Modern smartphone screens
                                            19.5 /
                                                9, // Full-screen edge-to-edge display
                                            21 / 9, // Ultra-wide cinematic
                                            9 / 16, // Vertical video (TikTok, Reels)
                                            4 / 3, // Classic 4:3 format
                                            1 / 1, // Square format
                                          ];
                                          setState(() {
                                            aspectRatio = aspectRatios[
                                                (aspectRatios.indexOf(
                                                                aspectRatio) +
                                                            1) >=
                                                        aspectRatios.length
                                                    ? 0
                                                    : aspectRatios.indexOf(
                                                            aspectRatio) +
                                                        1];
                                          });
                                        },
                                        icon: const Icon(Icons.image))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ));
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:my_video_player/models/video.dart';

// class PlayVideoPage extends StatefulWidget{
//   final Video video;
//   const PlayVideoPage({super.key, required this.video});
  
//   @override
//   State<StatefulWidget> createState() => _PlayVideoPageState();
  
// }

// class _PlayVideoPageState extends State<PlayVideoPage> {
//   late VlcPlayerController _vlcPlayerController;
//   @override
//   void initState() {
//     _vlcPlayerController = VlcPlayerController.file(File(widget.video.path));
//     _vlcPlayerController.play();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _vlcPlayerController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: VlcPlayer(controller: _vlcPlayerController, aspectRatio: 16/9, placeholder:const CircularProgressIndicator(),));
//   }
// }