import 'package:flutter/material.dart';

Future push<T>(BuildContext context, {required Widget screen}) async {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => screen,
  ));
}

Future pushAndRemove<T>(BuildContext context, {required Widget screen}) async {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
      (route) => false);
}
