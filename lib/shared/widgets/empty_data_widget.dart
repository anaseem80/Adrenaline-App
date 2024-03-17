import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  EmptyData({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                AssetImage("assets/exercise-walk.gif"),
                radius: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}