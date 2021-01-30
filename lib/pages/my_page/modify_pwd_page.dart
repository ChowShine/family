import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/library/flustars.dart';
import 'package:videochat_package/bean/tag_im_modify_passwd_entity.dart';
import 'package:videochat_package/bean/tag_WndAllSet_modifypasswd_entity.dart';
import 'package:oktoast/oktoast.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';

class ModifyPasswordPage extends StatefulWidget {
  @override
  ModifyPasswordState createState() => ModifyPasswordState();
}

class ModifyPasswordState extends State<ModifyPasswordPage> {
  double _fontSize;

  TextEditingController _inputOldPwd = new TextEditingController();
  TextEditingController _inputNewPwd = new TextEditingController();
  TextEditingController _inputCheckPwd = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fontSize = Constants.FontSize;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildBody(),
    );
  }

  Widget _builAppBar() {
    return AppBar(
          backgroundColor: Colors.white,
          title: Text('修改密码',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0.0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black),
        );

  }

  Widget _buildBody() {
    var borderRadius = BorderRadius.all(Radius.circular(ScreenMgr.setAdapterSize(20)),);
    var marginContain = EdgeInsets.fromLTRB(0, 0, 0, ScreenMgr.setAdapterSize(30));
    var paddingContain = EdgeInsets.all(ScreenMgr.setAdapterSize(30),);
    return SingleChildScrollView(
      child: Container(
        height: ScreenMgr.setAdapterSize(1920),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
        ),
        margin: marginContain,
        padding: paddingContain,
        width: ScreenMgr.setAdapterSize(1080),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenMgr.setAdapterSize(10), 0, ScreenMgr.setAdapterSize(100), 0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenMgr.setAdapterSize(20),
                    ),
                    Text(
                      "  原密码：",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          controller: _inputOldPwd,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Text(
                      '(20位以内)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenMgr.setAdapterSize(10), 0, ScreenMgr.setAdapterSize(100), 0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenMgr.setAdapterSize(20),
                    ),
                    Text(
                      "  新密码：",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          controller: _inputNewPwd,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Text(
                      '(20位以内)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenMgr.setAdapterSize(10), 0, ScreenMgr.setAdapterSize(100), 0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenMgr.setAdapterSize(20),
                    ),
                    Text(
                      "确认密码：",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          controller: _inputCheckPwd,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Text(
                      '(20位以内)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenMgr.setAdapterSize(40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(80.0), 0.0, ScreenMgr.setAdapterSize(80.0), 0.0),
                alignment: Alignment.center,
                child: TouchCallBack(
                  onPressed: () {
                    if (_inputOldPwd.text.isEmpty || _inputNewPwd.text.isEmpty || _inputCheckPwd.text.isEmpty){
                      showToast('密码不能为空，请输入');
                    }
                    else if (_inputNewPwd.text != _inputCheckPwd.text){
                      showToast("两次密码不一致，请重新输入");
                    } else {

                      TagWndAllSetModifypasswdEntity modifyPwd=new TagWndAllSetModifypasswdEntity();
                      modifyPwd.roomid=0;
                      modifyPwd.strOldPass=_inputOldPwd.text;
                      modifyPwd.strNewPass1=_inputNewPwd.text;
                      modifyPwd.strNewPass2=_inputCheckPwd.text;
                      modifyPwd.bConnectedLoginSvr=true;
                      Constants.cppplug.WndAllSet_modifypasswd(modifyPwd);
                    /*  TagImModifyPasswdEntity im_modify_password = new TagImModifyPasswdEntity();
                      im_modify_password.roomid = Constants.joinImSuccess.roomInfo.roomid;
                      im_modify_password.strOldPass = _inputOldPwd.text;
                      im_modify_password.strNewPass = _inputNewPwd.text;
                      im_modify_password.strCheckPass = _inputCheckPwd.text;
                      Constants.cppplug.im_modify_passwd(im_modify_password);*/
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenMgr.setHeight(120.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
//                          colors: [Color.fromARGB(255, 119, 196, 90),Color.fromARGB(255, 26, 141, 102)]
                      ),
                      borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
                      //border: Border.all(color: Colors.blue)
                    ),
                    child: Text(
                      '确定修改',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

}
