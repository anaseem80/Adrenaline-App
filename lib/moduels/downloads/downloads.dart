import 'dart:io';

import 'package:adrenaline/moduels/local_player/local_player.dart';
import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  late VideoPlayerController _controller;
  List<dynamic> lessons = [];
  List<dynamic> customLesson = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listofFiles();
    // _controller = VideoPlayerController.file(file)..addListener(() { setState(() {
    //
    // }); })..initialize().then((value) => _controller.play())
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }
  void deleteFile(filename) async {
    // Get the application documents directory.
    final directory = await getApplicationDocumentsDirectory();

    // Create a reference to the file you want to delete.
    final file = File('${directory.path}/${filename}.mp4');

    // Check if the file exists.
    if (await file.exists()) {
      // Delete the file.
      await file.delete();
      print('File deleted successfully.');
    } else {
      print('File does not exist.');
    }
  }
  void _listofFiles() async {
    String? directory;
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      lessons =io.Directory("$directory/").listSync();
      for(var lesson in lessons){
        if(lesson.path.contains("mp4")){
          customLesson.add(lesson.path.split("/").last.split("_").last.split(".")[0]);
        }
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          customLesson.length > 0 ? Text(
            "المحاضرات التي قمت بتنزيلها",
            style: TextStyle(
                color: whiteColor,
                fontSize: 18.0,
            ),
          ) : Container(),
          SizedBox(
            height: 10,
          ),
          customLesson.length > 0 ?
          Expanded(
            child: ListView.separated(
                itemCount: customLesson.length,
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(index.toString()),
                    onDismissed: (direction) {
                      deleteFile(customLesson[index].toString());
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(' تم الحذف بنجاح')));
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        IconlyBroken.delete,
                        color: Colors.white,
                      ),
                    ),

                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: lowWhiteColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Local_player(
                              lessonName: customLesson[index],
                            )),
                          );
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  customLesson[index].toString(),
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 17.0
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.play_arrow,
                                color: Colors.lightGreen,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ) : 
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/exercise-walk.gif"),
                        radius: 70,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "!😞 لم بتقم بتنزيل محاضرات حتي الأن",
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
