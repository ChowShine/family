//通用设置

import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import '../common/common_param.dart';
class CommonSetPage extends StatefulWidget {
  @override
  _CommonSetPageState createState() => _CommonSetPageState();
}

class _CommonSetPageState extends State<CommonSetPage> {
  bool isMsgOn=false;//消息推送
  String strCacheSize="0B";//缓存大小
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero,()async{
     strCacheSize=await Singleton.handleCache.loadCache();
      setState(() {

      });
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
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "通用设置",
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

    _buildBody(){
      return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          children: [
            Container(
              height:ScreenMgr.setAdapterSize(180.0),
              child: Row(
                children: [
                  CusText("消息推送",size:  CusFontSize.size_17,),
                  Spacer(),
                  Switch(
                    value: isMsgOn,
                    activeColor: Colors.blue,
                    onChanged: (value){
                      setState(() {
                        isMsgOn=value;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(height: ScreenMgr.setAdapterSize(5.0),color: Colors.grey[200],),
            TouchCallBack(
              onPressed: (){

              },
              child: Container(
                height:ScreenMgr.setAdapterSize(180.0),
                child: Row(
                  children: [
                    CusText("文字大小",size:  CusFontSize.size_17),
                    Spacer(),
                    CusText("中",color: Colors.grey,size:  CusFontSize.size_17)
                  ],
                ),
              ),
            ),
            Divider(height: ScreenMgr.setAdapterSize(5.0),color: Colors.grey[200],),
            TouchCallBack(
              onPressed: ()async{
                 await Singleton.handleCache.clearCache();
                 strCacheSize=await  Singleton.handleCache.loadCache();
                 setState(() {

                 });
              },
              child: Container(
                height:ScreenMgr.setAdapterSize(180.0),
                child: Row(
                  children: [
                    CusText("清理缓存",size:  CusFontSize.size_17),
                    Spacer(),
                    CusText("$strCacheSize",color: Colors.grey,size: CusFontSize.size_17)
                  ],
                ),
              ),
            ),
            Divider(height: ScreenMgr.setAdapterSize(5.0),color: Colors.grey[200],),
            TouchCallBack(
              onPressed: (){

              },
              child: Container(
                height:ScreenMgr.setAdapterSize(180.0),
                child: Row(
                  children: [
                    CusText("联系我们",size: CusFontSize.size_17),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Divider(height: ScreenMgr.setAdapterSize(5.0),color: Colors.grey[200],),
          ],
        ),
      );
    }

}//end_class
