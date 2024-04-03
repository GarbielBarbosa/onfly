import 'package:flutter/material.dart';

class Loading {
  final BuildContext context;
  Loading({required this.context});

  bool isDialogOpen = false;

  void showLoading() {
    if (!isDialogOpen) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (BuildContext context) {
          return const Dialog(
            backgroundColor: Color.fromARGB(66, 254, 254, 254),
            insetPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(),
            child: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
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
