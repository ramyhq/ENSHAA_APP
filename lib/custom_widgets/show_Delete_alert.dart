
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

showAlertDialog({required BuildContext context, required VoidCallback function}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed:  () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Delete for ever!"),
            onPressed:  () {
              function();
              Navigator.of(context).pop();
              GFToast.showToast(
                  'Deleted successfully',
                  context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: const TextStyle(fontSize: 16, color: GFColors.DARK),
                  backgroundColor: GFColors.LIGHT,
                  trailing: const Icon(
                    Icons.notifications,
                    color: GFColors.SUCCESS,
                  ));
            },
          )
        ],
      );
    },
  );
}