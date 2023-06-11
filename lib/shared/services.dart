import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void initFirebaseMessaging(BuildContext context) {
  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });

//when app is terminated
  FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null) {
      //use this while deeplinking
      //_onNotificationMessage(context, value);
    }
  });

//when app is in foreground
  FirebaseMessaging.onMessage.listen((message) {
    _onProcessMessage(context, message);
  });

//when app is in background

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    // use it while deeplinking
    //_onNotificationMessage(context, message);
  });
}

_onProcessMessage(BuildContext context, RemoteMessage message) async {
  var notification = message.notification;
  if (notification != null) {
    final title = notification.title;
    final body = notification.body;
    Flushbar(
      title: title,
      messageText: Visibility(
        visible: body != null,
        replacement: Container(),
        child: Text(
          body!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      icon: const Icon(
        Icons.message,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 4),
      // onTap: (f) => _onNotificationMessage(context, message),
    ).show(context);
  }
}
