import 'package:flutter/material.dart';


enum Status { success, error, info, warning, default_,}

class ToastSnackBar {
  final BuildContext context;
  final String message;
  final Status status;
  Color? color;

  ToastSnackBar({
    required this.context,
    required this.message,
    required this.status,
  }) {
    if (status == Status.success) {
      color = const Color(0xff17a00e);
    } else if (status == Status.error) {
      color = const Color(0xffce2336);
    } else if (status == Status.info) {
      color = Colors.blueGrey;
    } else if (status == Status.warning) {
      color = Colors.orange;
    } else if (status == Status.default_) {
      color = Colors.grey;
    }

    messageDisplay();
  }

  void messageDisplay() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

