// ignore_for_file: file_names

import 'package:flutter/material.dart';

SnackBar getSnackBar(text) {
  return SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
