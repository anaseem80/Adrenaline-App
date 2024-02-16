import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDF extends StatefulWidget {
  String? pdf;
  PDF({
    this.pdf,
  });
  @override
  State<PDF> createState() => _PDFState();
}

class _PDFState extends State<PDF> {
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
          // SfPdfViewer.network(widget.pdf.toString()),
          FutureBuilder<String>(
              future: getUserEmail(),
              builder: (context,snapshot) {
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
              }
          ),
        ],
      ),
    );
  }
}
