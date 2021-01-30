import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:videochat_package/constants/constants.dart';
import 'package:family_school/pages/homework_page/fs_homework_list_page.dart';
import 'package:family_school/pages/home_page/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:videochat_package/utilities/bugly_update.dart';
import 'package:family_school/pages/my_page/my_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int _pageindex = 0;
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  BuglyUpdate _buglyUpdate;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        Constants.isAppBackground = false;
        Constants.eventBus.emit("didChangeAppLifecycleState", null);
        print("应用程序可见，前台");
        if (Constants.joinImSuccess != null &&
            Constants.joinImSuccess.roomInfo != null &&
            Constants.joinImSuccess.roomInfo.roomid > 0) {
          Constants.cppplug.im_op_re_connect_im_server(Constants.joinImSuccess.roomInfo.roomid, 0);
        }
        if (Constants.joinRoomSuccess != null &&
            Constants.joinRoomSuccess.roomInfo != null &&
            Constants.joinRoomSuccess.roomInfo.roomid > 0) {
          Constants.cppplug.im_op_re_connect_im_server(Constants.joinRoomSuccess.roomInfo.roomid, 0);
        }
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        Constants.isAppBackground = true;
        print("应用程序不可见，后台");
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);


    Constants.eventBus.on("TagAliyunNotificationEntity", (event) {
      _showNotification(event.title, event.summary);
    });


    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS =
        new IOSInitializationSettings(onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings =
        new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

    _buglyUpdate = new BuglyUpdate(context, () {
      setState(() {});
    });
    _buglyUpdate.checkUpdate();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Constants.eventBus.off("TagAliyunNotificationEntity");
    Constants.cancelPushListener();
    _cancelAllNotifications();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _pageList[_pageindex], bottomNavigationBar: _buildBottomNavigationBar());
  }

  List<StatefulWidget> _pageList = [
    new HomePage(), //
    new HomeworkListPage(), //
    new HomePage(), //
    new MyPage() //
  ];

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: _pageindex == 0 ? selectedIcon[0] : unselectedIcon[0],
          title: _getBarText(0),
        ),
        new BottomNavigationBarItem(
          icon: _pageindex == 1 ? selectedIcon[1] : unselectedIcon[1],
          title: _getBarText(1),
        ),
        new BottomNavigationBarItem(
          icon: _pageindex == 2 ? selectedIcon[2] : unselectedIcon[2],
          title: _getBarText(2),
        ),
        new BottomNavigationBarItem(
          icon: _pageindex == 3 ? selectedIcon[3] : unselectedIcon[3],
          title: _getBarText(3),
        ),
      ],
      currentIndex: _pageindex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _pageindex = index;
        });
      },
    );
  }

  final List<Widget> selectedIcon = [
    Image.asset("${Constants.strImagesDir}fs_student_select.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_square_select.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_class_select.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_my_select.png", width: 24.0, height: 24.0)
  ];

  final List<Widget> unselectedIcon = [
    Image.asset("${Constants.strImagesDir}fs_student_unselect.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_square_unselect.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_class_unselect.png", width: 24.0, height: 24.0),
    Image.asset("${Constants.strImagesDir}fs_my_unselect.png", width: 24.0, height: 24.0),
  ];

  Widget _getBarText(int index) {
    if (index == 0) {
      return Text("学生", style: TextStyle(color: Colors.black87));
    } else if (index == 1) {
      return Text("广场", style: TextStyle(color: Colors.black87));
    } else if (index == 2) {
      return Text("课堂", style: TextStyle(color: Colors.black87));
    } else if (index == 3) {
      return Text("家长", style: TextStyle(color: Colors.black87));
    }
  }

  //点击通知处理
  Future onDidRecieveLocalNotification(int id, String title, String body, String payload) async {
    // 展示通知内容的 dialog.
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              //await Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen(payload);
            },
          )
        ],
      ),
    );
  }

  //点击通知处理
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    //payload 可作为通知的一个标记，区分点击的通知。
    if (payload != null && payload == "complete") {
      //await Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),);
    }
  }

  //显示通知
  Future _showNotification(String title, String content) async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    await flutterLocalNotificationsPlugin.show(0, title, content, platformChannelSpecifics, payload: 'complete');
  }

  //删除单个通知
  Future _cancelNotification() async {
    //参数 0 为需要删除的通知的id
    await flutterLocalNotificationsPlugin.cancel(0);
  }

//删除所有通知
  Future _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
