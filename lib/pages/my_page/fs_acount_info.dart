//账户信息

import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import '../common/common_param.dart';
import 'dart:io';
import 'package:videochat_package/pages/component/touch_callback.dart';
class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  @override
  void initState() {
    // TODO: implement initState
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
      appBar: AppBar(
        title: Text(
          "账户信息",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "保存",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Column(
        children: [
          Container(
            height: ScreenMgr.setAdapterSize(180.0),
            child: Row(
              children: [
                CusText(
                  "头像",
                  size: CusFontSize.size_17,
                ),
                Spacer(),
                TouchCallBack(
                  onPressed: (){

                  },
                    child: ClipOval(
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                          width: 60.0,
                          height: 60.0,
                        )) ?? Container())
              ],
            ),
          ),
          Divider(
            height: ScreenMgr.setAdapterSize(5.0),
            color: Colors.grey[200],
          ),
          Container(
            height: ScreenMgr.setAdapterSize(180.0),
            child: Row(
              children: [
                CusText(
                  "账号",
                  size: CusFontSize.size_17,
                ),
                Spacer(),
                CusText(
                  "18888888888",
                  color: Colors.grey,
                  size: CusFontSize.size_17,
                ),
              ],
            ),
          ),
          Divider(
            height: ScreenMgr.setAdapterSize(5.0),
            color: Colors.grey[200],
          ),
          Container(
            height: ScreenMgr.setAdapterSize(180.0),
            child: Row(
              children: [
                CusText("昵称", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "家长",
                  color: Colors.grey,
                  size: CusFontSize.size_17,
                ),
              ],
            ),
          ),
          Divider(
            height: ScreenMgr.setAdapterSize(5.0),
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  File imageFile;


} //end_class
