import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class MyVideoModal extends StatefulWidget {
  @override
  State<MyVideoModal> createState() => _MyVideoModalState();
}

class _MyVideoModalState extends State<MyVideoModal> {
  late final PodPlayerController controller;
  void initState() {
    super.initState();
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network("https://rr3---sn-a5m7lnld.googlevideo.com/videoplayback?expire=1708850979&ei=w6raZbmqId7csfIPhJ6-oAk&ip=173.201.180.24&id=o-ALZQy0oma0sc8Z6BQOkh6xos02Vp39V8Zrti-yFyqGYf&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=KK&mm=31%2C29&mn=sn-a5m7lnld%2Csn-a5meknzs&ms=au%2Crdu&mv=u&mvi=3&pl=20&vprv=1&mime=video%2Fmp4&cnr=14&ratebypass=yes&dur=3098.261&lmt=1699407155005125&mt=1708828449&fvip=2&fexp=24007246&c=ANDROID_EMBEDDED_PLAYER&txp=6218224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cvprv%2Cmime%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRAIgeunKuy_FT5vzP-frtXLvnOAWwctAVymj8XB8aIlKyygCICs2RRAWW3dauOLOb8rr-OKqaAPxJmW96DJCjDeeEBD8&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=APTiJQcwRQIhAMIQ-Ov8DHI-e91pUO2TRIQbbC5k9iQ8omTHQtvgQ8JvAiAnA-WSpPsXOtskEt6GHRa2iLEkkHnmbKeYuuDfmOBVeQ%3D%3D"),
    )..initialise();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8),
          PodVideoPlayer(controller: controller),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the modal when the button is clicked
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              ),
              primary: Colors.black,
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
            child: Text('إلغاء'),
          ),
        ],
      ),
    );
  }
}