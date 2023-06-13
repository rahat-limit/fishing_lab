import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

SnackBar snackBar(
    String label, String content, VoidCallback callback, Color color) {
  return SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    backgroundColor: (color),
    duration: const Duration(milliseconds: 1500),
    action: SnackBarAction(
      label: label,
      onPressed: callback,
    ),
  );
}

Future<void> defineDetail({
  required BuildContext context,
  required String title,
  required TextEditingController mController,
  required TextEditingController cmController,
  String label1 = 'M',
  String label2 = 'Cm',
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: mController,
                      decoration: InputDecoration(label: Text(label1)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: cmController,
                      decoration: InputDecoration(label: Text(label2)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const LocaleText('Back'),
            onPressed: () {
              mController.clear();
              cmController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const LocaleText('Set'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future showBottomModal(BuildContext context, Widget widget) async {
  await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      backgroundColor: lightScaffoldColor,
      builder: (context) {
        return widget;
      });
}
