//添加孩子

import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';

import '../common/common_param.dart';
import 'file:///D:/work/003007_yt_videochat_app_flutter/trunk/apps/family_school/lib/pages/provider/fs_my_provide.dart';
import 'package:oktoast/oktoast.dart';

class AddChildPage extends StatefulWidget {
  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage>
    with WidgetsBindingObserver {
  final FocusNode _focusNode = new FocusNode();
  final myController = TextEditingController();
  bool isKeyBoardOn = false;
  MyProvider provider = MyProvider();
  var inputVal;
  @override
  void initState() {
    // TODO: implement initState
    //初始化
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
          setState(() {
            isKeyBoardOn = false;
          });
        } else {
          //显示键盘
          setState(() {
            isKeyBoardOn = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isKeyBoardOn) {
          _focusNode.unfocus();
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "添加孩子",
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
                "提交",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                if (isKeyBoardOn) {
                  _focusNode.unfocus();
                }
                inputVal = myController.text;
                if (inputVal != '') {
                  await this.provider.reqAddChild(inputVal);
                  Navigator.of(context).pop();
                } else {
                  showToast('请输入邀请码！');
                }
              },
            )
          ],
        ),
        body: _buildBody(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Column(
        children: [
          Container(
            height: ScreenMgr.setAdapterSize(180.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CusText(
                    '邀请码',
                    size: CusFontSize.size_17,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "请输入老师提供的邀请码", border: InputBorder.none),
                    focusNode: _focusNode,
                    controller: myController,
                    keyboardType: TextInputType.number,
                  ),
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
} //end_class
