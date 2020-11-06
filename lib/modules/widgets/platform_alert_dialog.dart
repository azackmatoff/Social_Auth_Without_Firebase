import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialauthenthication/modules/widgets/platform_specific_widget.dart';

class PlatformAlertDialog extends PlatformSpecificWidget {
  final String subject;
  final String content;
  final String mainButtonText;
  final String cancelButtonText;

  PlatformAlertDialog(
      {@required this.subject,
      @required this.content,
      @required this.mainButtonText,
      this.cancelButtonText});

  Future<bool> choosePlatformToShowDialog(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(subject),
      content: Text(content),
      actions: _makeDialogButton(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(subject),
      content: Text(content),
      actions: _makeDialogButton(context),
    );
  }

  List<Widget> _makeDialogButton(BuildContext context) {
    final allButtons = <Widget>[];

    if (Platform.isIOS) {
      if (cancelButtonText != null) {
        allButtons.add(
          CupertinoDialogAction(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      allButtons.add(
        CupertinoDialogAction(
          child: Text(mainButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (cancelButtonText != null) {
        allButtons.add(
          FlatButton(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      allButtons.add(
        FlatButton(
          child: Text(mainButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    }

    return allButtons;
  }
}
