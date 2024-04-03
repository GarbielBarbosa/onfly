import 'package:flutter/material.dart';
import 'package:onfly/shared/dialogs/alert_dialog.dart';
import 'package:onfly/shared/dialogs/loading.dart';

class HomeController {
  final BuildContext context;
  final Loading loading;
  final SimpleAlertDialog alert;
  HomeController({required this.context})
      : loading = Loading(context: context),
        alert = SimpleAlertDialog(context: context);
}
