
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import '../common/common_func.dart';
import '../common/common_param.dart';

//首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

//重写被释放的方法，只释放TabController
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Center(child: Text("正在开发中......"),);
    return  SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              height: ScreenMgr.scrHeight,
            ),

            CusPadding(
              Container(
                width: double.infinity,
                height: ScreenMgr.scrHeight*0.6,
                margin: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                child: func_buildImageAsset("fs_home_bk.png", fit: BoxFit.fill),
              ),
              t: ScreenMgr.setAdapterSize(150.0),
              //b: ScreenMgr.scrHeight * 0.2,
            ),
            //顶部背景显示文字
            CusPadding(
              Container(
                  width: double.infinity,
                  height: ScreenMgr.scrHeight*0.6,
                  margin: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(30.0), 0.0, ScreenMgr.setAdapterSize(30.0), 0.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  CusText(
                                    "张梓涵",
                                    color: Colors.white,
                                    size: CusFontSize.size_16,
                                  ),
                                  CusText(
                                    "一年级6班",
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CusText(
                                    "5",
                                    color: Colors.white,
                                    size: CusFontSize.size_30,
                                  ),
                                  CusText(
                                    "本周排名",
                                    color: Colors.white,
                                    size: CusFontSize.size_14,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CusText(
                                    "98",
                                    color: Colors.white,
                                    size: CusFontSize.size_30,
                                  ),
                                  CusText(
                                    "本周分数",
                                    color: Colors.white,
                                    size: CusFontSize.size_14,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CusText(
                                    "3",
                                    color: Colors.white,
                                    size: CusFontSize.size_30,
                                  ),
                                  CusText(
                                    "未读通知",
                                    color: Colors.white,
                                    size: CusFontSize.size_14,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.fromLTRB(
                                ScreenMgr.setAdapterSize(50.0), 0.0, ScreenMgr.setAdapterSize(50.0), 0.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                              CusText(
                                "昨日表现",
                                color: Colors.white,
                                size: CusFontSize.size_16,
                              ),
                              Spacer(),
                              CusText(
                                "查看全部",
                                color: Colors.white,
                                size: CusFontSize.size_14,
                              )
                            ])),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenMgr.setAdapterSize(50.0), 0.0, ScreenMgr.setAdapterSize(50.0), 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: ScreenMgr.setAdapterSize(90.0),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                                child: Container(),
                              ),
                              Container(
                                height: ScreenMgr.setAdapterSize(90.0),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                                child: Container(),
                              ),
                              Container(
                                height: ScreenMgr.setAdapterSize(90.0),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                                child: Container(),
                              ),
                              Container(
                                height: ScreenMgr.setAdapterSize(90.0),
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                                child: Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              t: ScreenMgr.setAdapterSize(150.0),
              //b: ScreenMgr.scrHeight * 0.2,
            ),
            CusPadding(
              Container(
                height: ScreenMgr.scrHeight*0.5,
                margin: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(50.0), 0, ScreenMgr.setAdapterSize(50.0), 0.0),
              ),
              t: ScreenMgr.scrHeight * 0.65+ ScreenMgr.setAdapterSize(200.0),
            ),
            //底部文字
            CusPadding(
              Center(
                child: func_buildImageAsset("fs_my_btm_word.png", dScale: 3.0),
              ),
              t: ScreenMgr.scrHeight * 0.85,
            )
          ],
        ),

    );
  }
}
