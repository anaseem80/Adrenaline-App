import 'package:adrenaline/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserRatingWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final double userRating;
  final String userMessage;

  const UserRatingWidget({
    required this.userName,
    required this.userImage,
    required this.userRating,
    required this.userMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(userImage),
        ),
        SizedBox(height: 8),
        Text(
          userName,
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 8),
        RatingBar.builder(
          itemSize: 20,
          initialRating: userRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ), onRatingUpdate: (double value) {  },
        ),
        SizedBox(height: 8),
        Text(
          userMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
