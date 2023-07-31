// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';

// Download Resume Function
downloadFile(url) {
  AnchorElement anchorElement = AnchorElement(href: url);
  anchorElement.download = url.split('/').last;
  anchorElement.click();
}

// Snackbar Function
snackbar(BuildContext context, Widget msg, {bool isFloating = false}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: isFloating ? SnackBarBehavior.floating : null,
      width: isFloating ? 400 : null,
      shape: isFloating
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      backgroundColor: Colors.green[100],
      content: Center(
        child: msg,
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}
