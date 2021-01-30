//通知详情
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import '../common/common_param.dart';

class NoticeDetailsPage extends StatefulWidget {
  @override
  _NoticeDetailsPageState createState() => _NoticeDetailsPageState();
}

class _NoticeDetailsPageState extends State<NoticeDetailsPage> {
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
          "通知详情",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              height: ScreenMgr.setAdapterSize(100.0),
              child: CusText(
                "关于提醒家长下载APP的通知",
                fontWeight: FontWeight.bold,
                size: CusFontSize.size_18,
              )),
          Container(
              alignment: Alignment.centerLeft,
              height: ScreenMgr.setAdapterSize(100.0),
              child: CusText(
                "王卫平老师一年(6)班 10-20 14:25:30",
                size: CusFontSize.size_14,
                color: CusColorGrey.grey400,
              )),
        Expanded(
          child: Container(
                alignment: Alignment.topLeft,
                child: CusText(
                  "关于提醒家长下载APP的通知",
                  size: CusFontSize.size_16,
                ),
              ),
        ),

          Divider(
            color: CusColorGrey.grey200,
            height: ScreenMgr.setAdapterSize(5.0),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: ScreenMgr.setAdapterSize(200.0),
            child: Row(
              children: [
                CusText(
                  "附件：",
                  size: CusFontSize.size_16,
                ),
                Text(
                  "课时表.xls",
                  style: TextStyle(fontSize:16.0, decoration: TextDecoration.underline),
                ),
                Icon(Icons.file_download)
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
        ],
      ),
    );
  }
} //end_class
