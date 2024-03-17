import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../moduels/Intro_video/IntroVideo.dart';
import '../app_cubit.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Image.asset(
              AppCubit.get(context).isDark
                  ? "assets/dark_logo.png"
                  : "assets/small_logo.png",
              width: 150,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => MyVideoModal(),
              );
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
            child: Text(
              "طريقة إستخدام المنصة",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      bottom: PreferredSize(
        child: Container(
          height: 1.0,
          color: Colors.grey[50], // Choose the color of your border
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
    );
  }
}
