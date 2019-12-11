import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dzikr/screen/quran_new_screen.dart';
import 'package:dzikr/models/quran.dart';

class DzikrNotification extends StatefulWidget {
  @override
  _DzikrNotificationState createState() => _DzikrNotificationState();
}

class _DzikrNotificationState extends State<DzikrNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String groupKey;
  String groupChannelId;
  String groupChannelName;
  String groupChannelDescription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    groupKey = 'com.android.example.WORK_EMAIL';
    groupChannelId = 'grouped channel id';
    groupChannelName = 'grouped channel name';
    groupChannelDescription = 'grouped channel description';
    _showScheduled();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    var quran = await Quran().bukaQuran(index: 8);
    if (quran != null)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuranNewScreen(
                    quran: quran,
                    index: 17,
                    surah: 'Al-Kahf',
                    lastRead: 0,
                  )));
  }

  _showScheduled() async {
    var time = new Time(16, 26, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description',
      importance: Importance.Max,
      priority: Priority.High,
      style: AndroidNotificationStyle.BigText,
      setAsGroupSummary: true,
      groupKey: groupKey,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      0,
      'Pengingat Jumat',
      'Keutamaan membaca Al-Kahfi\n"Barangsiapa yang membaca surat Al-Kahfi pada hari Jum\'at, dia akan disinari cahaya di antara dua Jum\'at".\n{HR. An Nasa\'i dan Baihaqi. Syaikh Al Albani berkata hadits ini shahih - Shahihul Jami\' no. 6470}',
      Day.Friday,
      time,
      platformChannelSpecifics,
      payload: 'Scheduled',
    );
  }

  Future _showMasterNotif() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      playSound: false,
      enableVibration: false,
      setAsGroupSummary: true,
      groupKey: groupKey,
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'Pengingat Dzikir',
      'Sudahkah Anda berdzikir?',
      platformChannelSpecifics,
    );
  }
}
