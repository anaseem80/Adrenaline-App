import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class MCQ extends StatefulWidget {
  String? mcq;
  MCQ({
    this.mcq,
  });
  @override
  State<MCQ> createState() => _MCQState();
}

class _MCQState extends State<MCQ> {
  @override
  Widget build(BuildContext context) {
    Future<String> getUserEmail() async {
      var shared = await SharedPreferences.getInstance();
      return shared.getString('email').toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // WebView(
          //   initialUrl: widget.mcq,
          // ),
          FutureBuilder<String>(
              future: getUserEmail(),
              builder: (context, snapshot) {
                return Center(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(15 / 360),
                    child: Text(
                      '${snapshot.data}',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.4),
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
