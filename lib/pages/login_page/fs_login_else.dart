//其他手机登录

import '../common/common_func.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/customMgr/screenMgr.dart';
import 'package:videochat_package/constants/customMgr/widgetMgr.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import '../common/common_param.dart';
import 'dart:async';
import 'package:videochat_package/constants/customMgr/stringMgr.dart';
import 'package:oktoast/oktoast.dart';
import 'package:videochat_package/constants/customMgr/spMgr.dart';
import '../provider/login_provider.dart';

class FSLoginElsePage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FSLoginElsePage> {
  void Function(void Function()) my_setState;
  final TextEditingController mobileTextController = new TextEditingController(); //手机号
  final TextEditingController codeTextController = new TextEditingController(); //验证码
  String _strCode = ""; //获取请求验证码 用于验证与输入的是否相同
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    mobileTextController?.dispose();
    codeTextController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            //width: ScreenMgr.scrWidth,
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
                height: ScreenMgr.scrHeight / 3,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: ScreenMgr.setHeight(130.0),
                        margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)), color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CusText(
                              "+86",
                            ),
                            Icon(Icons.arrow_drop_down),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(bottom: ScreenMgr.setAdapterSize(8.0)),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: mobileTextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  hintText: "请输入手机号码",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: CusFontSize.size_16),
                                ),
                              ),
                            ))
                          ],
                        )),
                    Container(
                        height: ScreenMgr.setHeight(130.0),
                        margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)), color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: ScreenMgr.setAdapterSize(10.0)),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: codeTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    hintText: "请输入验证码",
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: CusFontSize.size_16),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenMgr.setAdapterSize(1.0),
                              height: ScreenMgr.setAdapterSize(50.0),
                              color: Colors.grey,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                if (!StringMgr.isMobileNumber(mobileTextController.text)) {
                                  showToast("手机格式不正确,请重新输入");
                                } else {
                                  countdown();
                                  var ret = await LoginProvider.getPhoneCodeReq(int.parse(mobileTextController.text));
                                  if (ret != "") _strCode = ret;
                                }
                              },
                              child: StatefulBuilder(builder: (_, my_setState) {
                                this.my_setState = my_setState;
                                return RepaintBoundary(
                                  child: Text(
                                    "$_codeCountdownStr",
                                    style: TextStyle(color: Colors.grey, fontSize: CusFontSize.size_14),
                                  ),
                                );
                              }),
                            )
                          ],
                        )),
                    Container(
                        height: ScreenMgr.setHeight(130.0),
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        alignment: Alignment.center,
                        child: TouchCallBack(
                          onPressed: () async {
                            if (_strCode != codeTextController.text) {
                              showToast("验证码不正确,请重新输入！");
                            } else {
                              await LoginProvider.onLogin(mobileTextController.text, this.context);
                              SpMgr sp = await SpMgr.getInstance();
                              sp.setString(PHONE_NUMBER, mobileTextController.text); //存储手机号
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0), color: Color.fromARGB(255, 187, 205, 253)),
                            child: Text(
                              "登 录",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              t: ScreenMgr.scrHeight / 3,
            ),
            /*    CusPadding(
              //底部文字显示
              Container(
                padding:
                    EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(200.0), 0.0, ScreenMgr.setAdapterSize(200.0), 0.0),
                alignment: Alignment.center,
                height: ScreenMgr.setAdapterSize(120.0),
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
        )),
      ),
    );
  }

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  void countdown() {
    if (_countdownTimer != null) {
      return;
    }
    // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
    _codeCountdownStr = '${_countdownNum--}s重新获取';
    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      my_setState(() {
        if (_countdownNum > 0) {
          _codeCountdownStr = '${_countdownNum--}s重新获取';
        } else {
          _codeCountdownStr = '获取验证码';
          _countdownNum = 59;
          _countdownTimer.cancel();
          _countdownTimer = null;
        }
      });
    });
  }
} //end_class
