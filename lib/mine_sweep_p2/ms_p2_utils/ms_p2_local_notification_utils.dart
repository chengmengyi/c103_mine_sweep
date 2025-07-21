import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../mine_sweep_utils/ms_tba/ms_tba_utils.dart' show MsTbaUtils;

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
            _clickNotification(response.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _clickNotification(response.id);
            break;
        }
      },
    );
    if(success!=true){
      return;
    }
    _setNotification();
    var launchDetails = await _plugins.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      _clickNotification(launchDetails?.notificationResponse?.id);
    }

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
      title: "Tripeak Win Bonus!",
      content: "Every Tripeak win today gives extra cash. Play more!",
      duration: Duration(minutes: 30),
    );
  }
  _notification2(){
    _showNotification(
      id: MsP2NotificationId.notification2,
      title: "Flip to Win Big!",
      content: "Today’s flip goal—get loads of cash. You’re close!",
      duration: Duration(minutes: 60),
    );
  }
  _notification3(){
    _showNotification(
      id: MsP2NotificationId.notification3,
      title: "Spin & Win More!",
      content: "Next spin gives double cash—get loads with one turn!",
      duration: Duration(minutes: 90),
    );
  }
  _notification4(){
    _showNotification(
      id: MsP2NotificationId.notification4,
      title: "Cash Streak Builder!",
      content: "5 wins in Tripeak + solitaire = massive cash streak! Keep going!",
      duration: Duration(hours: 3),
    );
  }
  _notification5(){
    _showNotification(
      id: MsP2NotificationId.notification5,
      title: "Tripeak Daily Gift!",
      content: "Log in, play 1 Tripeak game, get piles of cash. No catch!",
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

  _clickNotification(int? id){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.all_push_c,params: {"push_id":id});
  }
}