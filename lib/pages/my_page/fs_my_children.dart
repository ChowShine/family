//我的孩子

import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import '../common/common_param.dart';

class MyChildrenPage extends StatefulWidget {
  @override
  _MyChildrenPageState createState() => _MyChildrenPageState();
}

class _MyChildrenPageState extends State<MyChildrenPage> {
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
          "我的孩子",
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
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: ScreenMgr.setAdapterSize(400.0),
            child: Container(
              height: ScreenMgr.setAdapterSize(180.0),
              width: ScreenMgr.setAdapterSize(180.0),
              child: Stack(
                children: [

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: ScreenMgr.setAdapterSize(160.0),
            child: Row(
              children: [
                CusText("姓名", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "俞天骥",
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
            height: ScreenMgr.setAdapterSize(160.0),
            child: Row(
              children: [
                CusText("性别", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "男",
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
            height: ScreenMgr.setAdapterSize(160.0),
            child: Row(
              children: [
                CusText("年龄", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "7",
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
            height: ScreenMgr.setAdapterSize(160.0),
            child: Row(
              children: [
                CusText("班级", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "三(2)班",
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
            height: ScreenMgr.setAdapterSize(160.0),
            child: Row(
              children: [
                CusText("职务", size: CusFontSize.size_17),
                Spacer(),
                CusText(
                  "班委",
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
          Spacer(),
          Container(
            height: ScreenMgr.setAdapterSize(180.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: ScreenMgr.setHeight(120.0),
                  alignment: Alignment.center,
                  child: Material(
                      borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
                      color: Color.fromARGB(255, 194, 113, 112),
                      child: new MaterialButton(
                        onPressed: () {},
                        child: CusText(
                          "删除孩子",
                          color: Colors.white,
                        ),
                      )),
                ),
                Container(
                  height: ScreenMgr.setHeight(120.0),
                  alignment: Alignment.center,
                  child: Material(
                      borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
                      color: Color.fromARGB(255, 88, 158, 255),
                      child: new MaterialButton(
                        onPressed: () {},
                        child: CusText(
                          "默认展示",
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} //end_class
