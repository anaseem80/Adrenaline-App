import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:encrypt/encrypt.dart';

class DownloadingDialog extends StatefulWidget {
  String? url;
  DownloadingDialog({
    this.url,
  });
  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;
  void startDownloading(id) async {
    var permisson = await Permission.storage.request();
    if(permisson.isGranted){
      var _youtubeExplode = YoutubeExplode();
      var video = await _youtubeExplode.videos.get(id);
      var manifest = await _youtubeExplode.videos.streamsClient.getManifest(id.toString());
      var streamInfo = manifest.muxed.withHighestBitrate();
      print(streamInfo.size);

      final String url = streamInfo.url.toString();

      final String fileName = "aneumonoultPneumonoultramicroscopicsilicovolcanoconiosisramicroscopicsilicovolcanoconiosis"+ "_" +video.title + ".mp4";

      String path = await _getFilePath(fileName);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      print(appDocPath);
      await dio.download(
        url,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            progress = recivedBytes / totalBytes;
          });

          //print(progress);
        },
        deleteOnError: true,
      ).then((_) {
      });
    }else{
      await Permission.storage.request();
    }
  }

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

  @override
  void initState() {
    super.initState();
    startDownloading(widget.url!.split("/").last);
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
