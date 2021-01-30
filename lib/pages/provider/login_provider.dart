import 'package:dio/dio.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../common/common_param.dart';
import 'package:family_school/pages/mainpage.dart';
import 'package:videochat_package/utilities/bugly_update.dart';
import 'package:videochat_package/constants/customMgr/spMgr.dart';
import '../common/common_func.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class LoginProvider {
  static Future<String> getPhoneCodeReq(int phoneNum) async {
    try {
      Response resp = await Dio().post(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}code", queryParameters: {"phone": phoneNum});
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        if (mpData != null) {
          if (mpData["code"] == "0" && mpData["msg"] == "ok") {
            return mpData["data"].toString();
          } else {
            return Future.value("");
          }
        } else {
          return Future.value("");
        }
      }
    } catch (e) {
      print("$e");
      return Future.value("");
    }
  }

  //登录
static   Future<void> onLogin(String strPhoneNum,BuildContext context) async {
  {
    FamilyAuthenticationService.netType = gnNetType;
    await FamilyAuthenticationService.loginPostToken(strPhoneNum);
    if (FamilyAuthenticationService.isAuthenticated()) {

      //先判断是否需要升级
      SpMgr sp = await SpMgr.getInstance();
      String strOldVer = sp.getString("$VERSION");
      String strNewVer = FamilyAuthenticationService.version;
      if (strOldVer == "") {
        //第一次安装
        if (parseVersion("0.0.1") < parseVersion(strNewVer)) {
          //本地版本小于后台版本
          BuglyUpdate(context, () {
            sp.setString("$VERSION", strNewVer);
          }).upgrade(FamilyAuthenticationService.version, FamilyAuthenticationService.downLoadUrl, () {});
        } else {
          Constants.httpFamilyToken = FamilyAuthenticationService.getInstance();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainPage()), (Route<dynamic> rout) => false);
        }
      } else {
        //已存储，非第一次安装
        if (parseVersion(strOldVer) < parseVersion(strNewVer) /*&&parseVersion(g_strVer)<parseVersion(strNewVer)*/) {
          BuglyUpdate(context, () {
            sp.setString("$VERSION", strNewVer);
          }).upgrade(FamilyAuthenticationService.version, FamilyAuthenticationService.downLoadUrl, () {});
        } else {
          Constants.httpFamilyToken = FamilyAuthenticationService.getInstance();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainPage()), (Route<dynamic> rout) => false);
        }
      }
    } else {
      showToast("登录失败,请重新登录");
    }
  }
}
}
