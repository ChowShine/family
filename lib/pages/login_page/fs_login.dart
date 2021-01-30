//登录页面

import '../common/common_param.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import 'fs_login_else.dart';
import '../common/common_func.dart';
import 'package:videochat_package/constants/customMgr/spMgr.dart';
import '../provider/login_provider.dart';

class FSLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FSLoginPage> {
  String strPhoneNum = ""; //"19952840891";

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      SpMgr sp = await SpMgr.getInstance();
      String str = sp.getString(PHONE_NUMBER);
      if (str != "") {
        setState(() {
          strPhoneNum = str;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        Image.asset(
          "${Constants.strImagesDir}app_bk.png",
          width: ScreenMgr.scrWidth,
          height: ScreenMgr.scrHeight,
          fit: BoxFit.fill,
        ),
        CusPadding(
          //登录logo
          Center(
            child: Container(
              alignment: Alignment.center,
              width: ScreenMgr.setAdapterSize(200.0),
              height: ScreenMgr.setAdapterSize(200.0),
              child: func_buildImageAsset(
                "login_logo.png",
              ),
            ),
          ),
          t: ScreenMgr.scrHeight * 0.2,
          b: ScreenMgr.scrHeight * 0.65,
        ),
        CusPadding(
          Container(
              height: ScreenMgr.scrHeight * 0.55,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: ScreenMgr.setAdapterSize(160.0),
                    child: CusText(
                      strPhoneNum.isEmpty ? "" : "${strPhoneNum.replaceRange(3, 7, "****")}", //187****5555
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      size: CusFontSize.size_19,
                    ),
                  ),
                  Container(
                      height: ScreenMgr.setHeight(130.0),
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      alignment: Alignment.center,
                      child: TouchCallBack(
                        onPressed: () async {
                          await LoginProvider.onLogin(strPhoneNum, this.context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                ScreenMgr.setAdapterSize(100.0),
                              ),
                              color: Colors.white),
                          child: CusText(
                            "本机号码一键登录",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 112, 155, 122),
                          ),
                        ),
                      )),
                  TouchCallBack(
                    onPressed: () {
                      RouteMgr().push(context, FSLoginElsePage());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenMgr.setAdapterSize(160.0),
                      child: CusText(
                        "使用其他号码登录>",
                        color: Colors.white,
                        size: CusFontSize.size_14,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: ScreenMgr.setAdapterSize(60.0),
                    child: CusText(
                      "登录即代表同意《中国移动认证服务条款》和",
                      color: Colors.white,
                      size: CusFontSize.size_12,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: ScreenMgr.setAdapterSize(60.0),
                    child: CusText(
                      "《用户协议》、《隐私政策》并接受本平台获取本机号码",
                      color: Colors.white,
                      size: CusFontSize.size_12,
                    ),
                  ),
                ],
              )),
          t: ScreenMgr.scrHeight / 3,
        ),
        /*     CusPadding(
          //底部文字显示
          Container(
            padding: EdgeInsets.fromLTRB(ScreenMgr.scrWidth * 0.2, 0.0, ScreenMgr.scrWidth * 0.2, 0.0),
            alignment: Alignment.center,
            height: ScreenMgr.setAdapterSize(140.0),
            child: Image.asset(
              "${Constants.strImagesDir}fs_login_btm_bk.png",
              color: Colors.white,
            ),
          ),
          t: ScreenMgr.scrHeight * 0.9,
        ),*/
        CusPadding(
          //顶部云朵
          Container(
            alignment: Alignment.center,
            height: ScreenMgr.setAdapterSize(400.0),
            width: ScreenMgr.scrWidth,
            child: Image.asset(
              "${Constants.strImagesDir}fs_cloud_bk.png",
              color: Colors.white,
              fit: BoxFit.fitWidth,
            ),
          ),
          t: ScreenMgr.setAdapterSize(40.0),
        ),
      ],
    )));
  }
} //end_class
