import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget contentText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      height: 1.3,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget contentTextGrey(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      height: 1.3,
      color: Colors.grey,
    ),
    textAlign: TextAlign.justify,
  );
}

Widget iconAndTextResponse(String lottie, String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Lottie.asset(lottie),
        ),
        contentText(text)
      ],
    ),
  );
}
