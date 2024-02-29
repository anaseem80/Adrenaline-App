import 'dart:io';
import 'dart:typed_data';

import 'package:adrenaline/shared/compontents/compenants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
// import 'package:better_player/better_player.dart';
import 'package:pod_player/pod_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as esc;

class Local_player extends StatefulWidget {
  String? lessonName;
  Local_player({
    this.lessonName,
  });
  @override
  State<Local_player> createState() => _Local_playerState();
}

class _Local_playerState extends State<Local_player> {
  late final PodPlayerController controller;
  // late VideoPlayerController videoPlayerController;
  // late ChewieController chewieController;
  var isVideoPlaying;
  String? directory;
  @override
  void initState() {
    super.initState();
    getfile();
  }

  void getfile() async {
    final dir = await getApplicationDocumentsDirectory();
    final File file = File("${dir.path}/${widget.lessonName}.mp4");
    setState(() {
      // videoPlayerController = VideoPlayerController.file(file)..initialize();
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.file(file),
      )..initialise().then((value) {
        setState(() {
          isVideoPlaying = controller.isVideoPlaying;
        });
      });
      controller.addListener(() {
        if(controller.isVideoPlaying==false){
          controller.pause();
          return;
        }
      });
      controller.addListener(_listner);

      // chewieController = ChewieController(
      //   videoPlayerController: videoPlayerController,
      //   autoPlay: true,
      //   looping: true,
      //   showControls: true,
      //   allowFullScreen: true,
      //   materialProgressColors: ChewieProgressColors(
      //     playedColor: Colors.red,
      //   ),
      //   playbackSpeeds: [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.5, 3, 3.5],
      //   fullScreenByDefault: true,
      // );
    });
  }
  void _listner() {
    if (controller.isVideoPlaying != isVideoPlaying) {
      isVideoPlaying = controller.isVideoPlaying;
    }
    if (mounted) setState(() {});
  }
  // void getNormalFile() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   _getNormalFile(dir, "${widget.lessonName}");
  // }

  void dispose() {
    controller.removeListener(_listner);
    controller.dispose();
    // chewieController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // final file = await _localFile;
          // await file.delete();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                widget.lessonName.toString(),
              ),
            ),
          ),
          body: PodVideoPlayer(controller: controller),
        ),
      ),
    );
  }
}
