import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MsP2NotificationId{
  static const int notification1=1;
  static const int notification2=2;
  static const int notification3=3;
  static const int notification4=4;
  static const int notification5=5;
}

class MsP2LocalNotificationUtils {
  static final MsP2LocalNotificationUtils _utils=MsP2LocalNotificationUtils();
  static MsP2LocalNotificationUtils get instance => _utils;

  final _plugins=FlutterLocalNotificationsPlugin();

  init()async{
    var success = await _plugins.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        switch (response.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            // _clickLocalNotification(notificationResponse.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            // _clickLocalNotification(notificationResponse.id);
            break;
        }
      },
    );
    if(success!=true){
      return;
    }
    _setNotification();
  }

  _setNotification(){
    _notification1();
    _notification2();
    _notification3();
    _notification4();
    _notification5();
  }

  _notification1(){
    _showNotification(
      id: MsP2NotificationId.notification1,
      title: "Tripeak Cash Boost!",
      content: "Ace a Tripeak round, bag extra cash! Grab it now!",
      duration: Duration(minutes: 30),
    );
  }
  _notification2(){
    _showNotification(
      id: MsP2NotificationId.notification2,
      title: "Solitaire Lucky Spin!",
      content: "Nail a solitaire game, unlock a lucky spin for cash! Tap in!",
      duration: Duration(minutes: 60),
    );
  }
  _notification3(){
    _showNotification(
      id: MsP2NotificationId.notification3,
      title: "Double Rewards Alert!",
      content: "Play both Tripeak and solitaire, earn double cash today!",
      duration: Duration(minutes: 90),
    );
  }
  _notification4(){
    _showNotification(
      id: MsP2NotificationId.notification4,
      title: "Cash Streak Builder!",
      content: "wins in Tripeak + solitaire = massive cash streak! Keep going!",
      duration: Duration(hours: 3),
    );
  }
  _notification5(){
    _showNotification(
      id: MsP2NotificationId.notification5,
      title: "Top Gamers Cash Out!",
      content: "Top Gamers Earn Huge! Instant Cash Rewards!",
      duration: Duration(hours: 5),
    );
  }

  _showNotification({
    required int id,
    required String title,
    required String content,
    required Duration duration,
  }){
    _plugins.periodicallyShowWithDuration(
      id,
      title,
      content,
      duration,
      const NotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}