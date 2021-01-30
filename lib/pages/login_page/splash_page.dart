import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:videochat_package/constants/constants.dart';
import 'fs_login.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  @override
  _SplashPage createState() => new _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  bool isStartHomePage = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: goToHomePage, //设置页面点击事件
      child: Image.asset(
        "${Constants.strImagesDir}splash.jpg",
        fit: BoxFit.fill,
        width: ScreenMgr.scrWidth,
        height: ScreenMgr.scrHeight,
      ),
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();

    //开启倒计时
    countDown();
  }

  @override
  void dispose() {
    Constants.eventBus.off("InitAppDataPathEndEvent");
    super.dispose();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 2);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage() async {
    /*String strUserName = "", strPsw = "";
    SharedPreferences sp = await SharedPreferences.getInstance();
    strUserName = sp.getString("username");
    strPsw = sp.getString("psw");*/
    {
      //如果页面还未跳转过则跳转页面
      if (!isStartHomePage) {
        //跳转主页 且销毁当前页面
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => new FSLoginPage()), (Route<dynamic> rout) => false); //
        isStartHomePage = true;
      }
    }
  }
}
