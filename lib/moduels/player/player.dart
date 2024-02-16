import 'dart:io';
import 'dart:isolate';
import 'package:arabmedicine/moduels/player/cubit/player_layout_cubit.dart';
import 'package:arabmedicine/moduels/video/video.dart';
import 'package:arabmedicine/shared/compontents/compenants.dart';
import 'package:arabmedicine/shared/compontents/imports.dart';
import 'package:arabmedicine/shared/styles/styles.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/services.dart';
import 'package:arabmedicine/moduels/player/downloading_dialog.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:encrypt/encrypt.dart' as esc;
import 'package:http/http.dart' as http;

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

var url2;

class player extends StatefulWidget {
  String? url;
  String? lessoneName;

  player({
    this.url,
    this.lessoneName
  });
  @override
  State<player> createState() => _playerState();
}

class _playerState extends State<player> {
  Dio dio = Dio();
  var client = new http.Client();
  double progress = 0.0;
  List<double> downloadProgress = [];
  List<bool> downloading = [];
  bool startedDownloadingLec = false;
  bool showAlternativeWidget = false;
  String? videoId;
  Future<void>? _controllerInitialization;
  CancelToken cancelToken = CancelToken();
  void startDownloading(int videoIndex, url, startedDownloadingLec,download,disabledButtons) async {
    var permisson = await Permission.storage.request();
    String path = await _getFilePath(widget.lessoneName.toString() + ".mp4");
    final dir = await getApplicationDocumentsDirectory();
    String appDocPath = dir.path;
    final bodyBytes = client.readBytes(Uri.parse(url));
    showToast(
      message: "يتم التحميل برجاء الانتظار",
      color: Colors.orange
    );
    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          downloadProgress[videoIndex] = recivedBytes / totalBytes;
          disabledButtons[videoIndex] = true;
        });
      },
      deleteOnError: true,
      cancelToken: cancelToken,
    ).then((_) {
      showToast(
          message: "تم التحميل بنجاح",
          color: Colors.green
      );
      setState(() {
        download[videoIndex] = false;
        disabledButtons[videoIndex] = false;
      });
    }).catchError((error) {
      if (CancelToken.isCancel(error)) {
        // download was cancelled
        showToast(
            message: "تم إلغاء التحميل",
            color: Colors.red
        );
      } else {
        // some other error occurred
        showToast(
            message: "حدث خطأ أثناء التحميل",
            color: Colors.red
        );
        setState(() {
          downloading[videoIndex] = false;
          disabledButtons[videoIndex] = false;
        });
      }
    });

  }
  // Future<void> _initializeController(String urll) async {
  //   String? url = widget.url;
  //   final videoId = YoutubePlayer.convertUrlToId(url!);
  //   // controller = PodPlayerController(
  //   //   playVideoFrom: PlayVideoFrom.network(url2),
  //   // );
  //   print('controller: $controller');
  //   flickManager = FlickManager(
  //     videoPlayerController:
  //     VideoPlayerController.network(urll),
  //   );
  //   await controller.initialise();
  // }
  Future<String> _getFilePath(filename) async {
    final dir = await getApplicationDocumentsDirectory();
    String appDocPath = dir.path;
    var file = File('$appDocPath/${filename}');
    //delete file if exists
    if (file.existsSync()) {
      file.deleteSync();
    }
    return "${dir.path}/$filename";
  }
  void updateDownloadingStatus(bool status) {
    setState(() {
      startedDownloadingLec = status;
    });
  }

  @override
  void initState() {
    super.initState();
    String? url = widget.url;
    videoId = '';
    //_controllerInitialization = _initializeController('url2');
  }
  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lessoneName.toString()
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // FutureBuilder<void>(
              //   future: _controllerInitialization,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //     print('dataSource: ${flickManager}');
              //     return FlickVideoPlayer(
              //         flickManager: flickManager
              //     );
              //   },
              // ),
              BlocProvider(
                  create: (context) => PlayerLayoutCubit()..getVideo(widget.url),
                  child: BlocConsumer<PlayerLayoutCubit, PlayerLayoutState>(
                      listener: (context, state) async {
                      },
                      builder: (context, state) {
                        var cubit = PlayerLayoutCubit.get(context);
                        if(state is PlayerLayoutLoading){
                          return Center(
                              child: CircularProgressIndicator()
                          );
                        }
                        else if (state is PlayerLayoutLoaded){
                          return SingleChildScrollView(
                            child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, video) {
                                    for (int i = 0; i < cubit.lecture!.url!.length; i++) {
                                      downloadProgress.add(0.0);
                                      downloading.add(false);
                                    }
                                    url2 = cubit.lecture!.url?[0].url;
                                    List<bool> disabledButtons = List.generate(cubit.lecture!.url!.length, (_) => false);
                                    String downloadingProgress = (downloadProgress[video] * 100).toInt().toString();
                                    return Container(
                                        padding: EdgeInsets.all(12.0),
                                        color: lowWhiteColor,
                                        margin: EdgeInsets.all(7),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${cubit.lecture!.url?[video].quality?? ''}",
                                                  style:TextStyle(
                                                    color: whiteColor,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    downloading[video]
                                                        ? Stack(
                                                      alignment: Alignment.topLeft,
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.all(15.0),
                                                          margin: const EdgeInsets.all(8.0),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                            color: lowWhiteColor,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  CircularProgressIndicator.adaptive(
                                                                    strokeWidth: 2,
                                                                    value: progress,
                                                                  ),
                                                                  Text(
                                                                    "$downloadingProgress%",
                                                                    style: TextStyle(
                                                                      color: whiteColor,
                                                                      fontSize: 10,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 10),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    downloading[video] = false;
                                                                  });
                                                                  cancelToken.cancel();
                                                                  cancelToken = CancelToken();
                                                                },
                                                                child: Text("Cancel"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : IconButton(
                                                      onPressed: disabledButtons[video]
                                                          ? null // button is disabled
                                                          : () async {
                                                        setState(() {
                                                          downloading[video] = true;
                                                          disabledButtons[video] = true;
                                                        });
                                                        startDownloading(
                                                          video,
                                                          cubit.lecture!.url?[video].url,
                                                          startedDownloadingLec,
                                                          downloading,
                                                          disabledButtons,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.downloading,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed:() async {
                                                        url2 = cubit.lecture!.url?[video].url;
                                                        //await _initializeController(url2);
                                                        Navigator.push<void>(
                                                          context,
                                                          MaterialPageRoute<void>(
                                                            builder: (BuildContext context) => LectureView(
                                                                url: url2,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.play_arrow,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(
                                    width: 20.0,
                                  ),
                                  itemCount: cubit.videos[0]['url'].length,
                                ),
                          );
                        }
                        else if(state is PlayerLayoutFailed){
                          return Center(
                            child: Container(
                              //child: Text(state.error),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      }
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}