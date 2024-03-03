import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import 'package:intercom_flutter/intercom_flutter.dart';

GetStorage storage = GetStorage();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static int item = 1;

  static initializeService() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: storage.read("sound") ?? true,
    );

    item = 1;
    try {
      firebaseMessaging.requestPermission(sound: true, badge: true, alert: true, provisional: true);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (kDebugMode) {
      print(storage.read("fcmToken").toString());
    }

/*    if (isSwipeCartApp) {
      try {
        await Intercom.instance.initialize('appIdHere', iosApiKey: 'iosKeyHere', androidApiKey: 'androidKeyHere');
        final intercomToken = Platform.isIOS ? await firebaseMessaging.getAPNSToken() : await firebaseMessaging.getToken();
        Intercom.instance.sendTokenToIntercom(intercomToken ?? "");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }*/

    firebaseMessaging.getToken().then((String? token) async {
      assert(token != null);
      if (kDebugMode) {
        print("FCM-TOKEN $token");
      }
      storage.write("fcmToken", token);
    });
  }

  static getNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      if (kDebugMode) {
        print(message);
        print("--------------------------${message.data}");
      }
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print(message.data);
      }
      // NotificationController.to.notificationReadCall(
      //     params: {'"userid"': '"${getUserDetails().userId}"', '"notification_id"': '"${message.data["notification_id"]}"'}, callBack: () {});
      notificationShow(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static notificationShow(data) {
    // if (data["screen"] == "POST_LIKED" || data["screen"] == "POST_COMMENT" || data["screen"] == "POST_COMMENT") {
    //   Get.offAll(() => const MainScreen());
    //   Get.to(() => CommentsScreen(slugId: data["post_slug"], isBackHome: false));
    // } else if (data["screen"] == "NEW_CHAT_MESSAGE") {
    //   Map<String,dynamic> chatData = json.decode(data["chatRoom"]);
    //   Get.to(() => ChatBoxScreen(
    //     isBackHome: true,
    //     id: chatData["id"],
    //     jobTitle: chatData["receiverJobTitle"],
    //     chatRoom: chatData["room_id"],
    //     receiverName: "${chatData["sender"]["first_name"]} ${chatData["sender"]["last_name"]}",
    //     receiverProfile: chatData["sender"]["profile_image"],
    //   ));
    // } else if (data["screen"] == "APPLICATION_PROCESS") {
    //   Get.to(() => const ApplicationScreen(isBackHome: true));
    // }

    // switch (pageId.toString()) {
    //   case "1":
    //     Get.to(() => const LoginScreen());
    //     break;
    //   case "2":
    //     Get.to(() => const HomeScreen());
    //     break;
    //   case "3":
    //     Get.to(() => const OffersProductScanningScreen());
    //     break;
    //   case "4":
    //     Get.to(() => const ScreenDetailsScreen());
    //     break;
    //   case "5":
    //     Get.to(() => const ReferalDetailsScreen());
    //     break;
    //   case "6":
    //     Get.to(() => const BankManagementScreen());
    //     break;
    //   case "7":
    //     Get.to(() => const AddBankScreen());
    //     break;
    //   case "8":
    //     Get.to(() => const TransactionHistoryScreen());
    //     break;
    //   case "9":
    //     Get.to(() => const ReferralListScreen());
    //     break;
    //   case "10":
    //     Get.to(() => const WithdrawalRequestScreen());
    //     break;
    //   case "11":
    //     Get.to(() => const WithdrawalHistoryListScreen());
    //     break;
    //   case "12":
    //     Get.to(() => const QrScannerScreen());
    //     break;
    // }
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print(message.data);
    }
    // NotificationController.to.notificationReadCall(
    //     params: {'"userid"': '"${getUserDetails().userId}"', '"notification_id"': '"${message.data["notification_id"]}"'}, callBack: () {});
    notificationShow(message.data);
  }

  static showNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    var android = const AndroidNotificationDetails('channel id', 'channel NAME', priority: Priority.high, importance: Importance.max);
    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    var jsonData = jsonEncode(message.data);

    flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
      if (kDebugMode) {
        print(payload);
        if (payload != null) {
          var jsonData = jsonDecode(payload.payload ?? "{}");
          // NotificationController.to.notificationReadCall(
          //     params: {'"userid"': '"${getUserDetails().userId}"', '"notification_id"': '"${message.data["notification_id"]}"'}, callBack: () {});
          notificationShow(jsonData);
        }
      }
    });

    await flutterLocalNotificationsPlugin.show(item++, message.notification!.title ?? "", message.notification!.body ?? "", platform,
        payload: jsonData);
  }
}
