import 'package:adrenaline/shared/compontents/imports.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

class LectureView extends StatefulWidget {
  String? url;
  LectureView({
    this.url,
  });
  @override
  State<LectureView> createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> {
  // late VideoPlayerController videoPlayerController;
  // late ChewieController chewieController;
  var isVideoPlaying;
  late final PodPlayerController controller;
  void initState() {
    super.initState();
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(widget.url.toString()),
      podPlayerConfig: const PodPlayerConfig(
        videoQualityPriority:const [1080, 720, 480, 360, 144],
      ),
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
  }
  void playVideo() async{
    // setState(() {
    //
    //   // videoPlayerController = VideoPlayerController.network(
    //   //     widget.url.toString()
    //   // )..initialize();
    //   // chewieController = ChewieController(
    //   //   videoPlayerController: videoPlayerController,
    //   //   autoPlay: true,
    //   //   looping: true,
    //   //   showControls: true,
    //   //   materialProgressColors: ChewieProgressColors(
    //   //     playedColor: Colors.red,
    //   //   ),
    //   //   playbackSpeeds: [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.5, 3, 3.5],
    //   //   fullScreenByDefault: true,
    //   // );
    // });

  }
  void _listner() {
    if (controller.isVideoPlaying != isVideoPlaying) {
      isVideoPlaying = controller.isVideoPlaying;
    }
    if (mounted) setState(() {});
  }
  @override
  void dispose() {
    controller.removeListener(_listner);
    controller.dispose();
    // chewieController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: PodVideoPlayer(controller: controller),
      // body: Chewie(
      //   controller: chewieController,
      // ),
    );
  }
}
