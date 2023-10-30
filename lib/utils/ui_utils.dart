import 'package:flutter/material.dart';

SnackBar getSnackBar(String value) {
  return SnackBar(content: Text(value));
}

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_sharp,
            color: Theme.of(context).primaryColor,
            size: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(message)
        ],
      ),
    ),
  );
}
