import 'package:flutter/material.dart';

class SimpleAlertDialog {
  final BuildContext context;
  SimpleAlertDialog({required this.context});

  bool isDialogOpen = false;

  void showAlert({
    required String title,
    required String message,
    required String closeButton,
  }) {
    if (!isDialogOpen) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(closeButton),
                onPressed: () {
                  isDialogOpen = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      isDialogOpen = true;
    }
  }

  void closeLoading() {
    if (isDialogOpen) {
      Navigator.of(context).pop();
      isDialogOpen = false;
    }
  }
}
