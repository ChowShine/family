import 'package:family_school/pages/my_page/fs_acount_info.dart';
import 'package:family_school/pages/my_page/fs_add_children_page.dart';
import 'package:family_school/pages/my_page/fs_common_set.dart';
import 'package:family_school/pages/my_page/fs_growth_process.dart';
import 'package:family_school/pages/my_page/fs_my_children.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/library/flustars.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import 'dart:io';
import '../common/common_func.dart';
import '../common/common_param.dart';
import 'package:videochat_package/constants/customMgr/datetimeMgr.dart';
import 'package:family_school/pages/login_page/fs_login.dart';
import 'package:provider/provider.dart';
import '../provider/fs_my_provide.dart';
import '../model/fs_my_model.dart';
import 'package:videochat_package/constants/customMgr/dlgMgr.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String strUserName = "";
  MyProvider provider = MyProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await this.provider.reqMy();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ChangeNotifierProvider<BaseProvider<MyModel>>(
      create: (_) => provider,
      child: Consumer<BaseProvider<MyModel>>(
        builder: (_, provider, child) => this.provider.myData == null
            ? LoadingDialog()
            : SingleChildScrollView(
                child: Container(
                    color: CusColorGrey.grey200,
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            CusPadding(Image.asset(
                              "${Constants.strImagesDir}fs_my_bk.png",
                              fit: BoxFit.fill,
                              width: ScreenMgr.scrWidth,
                              height: ScreenMgr.scrHeight * 0.4,
                            )),
                            Container(
                              height: ScreenMgr.scrHeight * 0.4,
                              child: RepaintBoundary(
                                child: TouchCallBack(
                                  onPressed: () async {
                                    RouteMgr().push(
                                        context,
                                        AccountInfoPage(this.provider.myData?.head ?? '',
                                            this.provider.myData?.username ?? '', this.provider.myData?.phone ?? ''));
                                    // await Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (_) => AccountInfoPage()))
                                    //     .then((value) {
                                    //   setState(() {
                                    //     //重新刷新更新头像
                                    //   });
                                    // });
                                  },
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        VSpacer(
                                          ScreenMgr.setAdapterSize(220.0),
                                        ),
                                        RepaintBoundary(
                                          child: ClipOval(
                                              child: Container(
                                                  width: ScreenMgr.setAdapterSize(200.0),
                                                  height: ScreenMgr.setAdapterSize(200.0),
                                                  child: Image.network(
                                                    "${this.provider.myData?.head ?? ''}",
                                                    fit: BoxFit.fill,
                                                  ))),
                                        ),
                                        VSpacer(
                                          ScreenMgr.setAdapterSize(20.0),
                                        ),
                                        CusText(
                                          "${this.provider.myData?.username ?? ''}",
                                          color: Colors.white,
                                          //fontWeight: FontWeight.bold,
                                          size: 18.0,
                                        ),
                                        CusText(
                                          "${this.provider.myData?.phone?.replaceFirst(new RegExp(r'\d{4}'), '****', 3) ?? ''}",
                                          color: Colors.white,
                                          size: CusFontSize.size_12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CusPadding(
                              Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  height: ScreenMgr.setAdapterSize(300.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: TouchCallBack(
                                            onPressed: () {
                                              //buildUpdateDlg();
                                              RouteMgr().push(context, MyHomePage());
                                            },
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "${Constants.strImagesDir}fs_my_class.png",
                                                    scale: 3.0,
                                                  ),
                                                  VSpacer(
                                                    ScreenMgr.setAdapterSize(30.0),
                                                    color: Colors.transparent,
                                                  ),
                                                  CusText(
                                                    "成长历程",
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: TouchCallBack(
                                            onPressed: () {
                                              RouteMgr().push(context, AddChildPage()).then((value) {
                                                this.provider.reqMy();
                                              });
                                            },
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "${Constants.strImagesDir}fs_my_add_student.png",
                                                    scale: 3.0,
                                                  ),
                                                  VSpacer(
                                                    ScreenMgr.setAdapterSize(30.0),
                                                    color: Colors.transparent,
                                                  ),
                                                  CusText(
                                                    "添加孩子",
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: TouchCallBack(
                                            onPressed: () {
                                              RouteMgr().push(context, CommonSetPage());
                                            },
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "${Constants.strImagesDir}fs_my_set.png",
                                                    scale: 3.0,
                                                  ),
                                                  VSpacer(
                                                    ScreenMgr.setAdapterSize(30.0),
                                                    color: Colors.transparent,
                                                  ),
                                                  CusText(
                                                    "通用设置",
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  )),
                              t: ScreenUtil.getInstance().screenHeight * 0.3,
                            ),
                            CusPadding(
                                Container(
                                  padding: EdgeInsets.only(left: ScreenMgr.setAdapterSize(50.0)),
                                  height: ScreenMgr.setAdapterSize(150.0),
                                  width: ScreenMgr.scrWidth * 0.4,
                                  alignment: Alignment.centerLeft,
                                  child: Stack(
                                    children: [
                                      Image.asset("${Constants.strImagesDir}fs_my_date_bk.png"),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenMgr.setAdapterSize(35.0), top: ScreenMgr.setAdapterSize(6.0)),
                                          child: CusText(
                                            "${transDateTime(DateTime.now())} ${DateTimeMgr().getWeekDay(DateTime.now().toString())}",
                                            color: Colors.white,
                                            size: CusFontSize.size_15,
                                          ))
                                    ],
                                  ),
                                ),
                                t: ScreenMgr.setAdapterSize(100.0)),
                          ],
                        ),
                        CusPadding(
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Column(
                              children: <Widget>[
                                Container(height: ScreenMgr.setAdapterSize(30), color: Colors.grey[200]),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: CusText(
                                            "我的孩子",
                                            size: 18.0,
                                            //fontWeight: FontWeight.bold,
                                          )),
                                      Container(
                                          child: ListView.builder(
                                        itemCount: this.provider.childList.length,
                                        itemBuilder: (context, index) {
                                          return _myList(index);
                                        },
                                        shrinkWrap: true,
                                        //禁止ListView.builder滚动
                                        physics: NeverScrollableScrollPhysics(),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(height: ScreenMgr.setAdapterSize(100), color: Colors.grey[200]),
                                Container(
                                    height: ScreenMgr.setHeight(130.0),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenMgr.setAdapterSize(150.0), 0.0, ScreenMgr.setAdapterSize(150.0), 0.0),
                                    alignment: Alignment.center,
                                    child: TouchCallBack(
                                      onPressed: () async {
                                        //await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                        // exit(0);
                                        RouteMgr().push(context, FSLoginPage());
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(26.0),
                                            color: Color.fromARGB(255, 58, 158, 255)),
                                        child: Text(
                                          "退出登录",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                                Container(
                                  height: ScreenMgr.setAdapterSize(100.0),
                                  child: Image.asset(
                                    "${Constants.strImagesDir}fs_my_btm_word.png",
                                    width: ScreenMgr.scrWidth * 0.6,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
      ),
    );
  }

  //升级对话框
  buildUpdateDlg() async {
    await showDialog(
        context: this.context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: ScreenMgr.scrHeight * 0.7,
                width: ScreenMgr.scrWidth * 0.75,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          CusPadding(
                            Container(
                              width: ScreenMgr.scrWidth * 0.7,
                              color: Colors.white,
                            ),
                            t: ScreenMgr.setAdapterSize(200.0),
                          ),
                          Container(
                              color: Colors.transparent,
                              width: ScreenMgr.scrWidth * 0.7,
                              child: Image.asset(
                                "${Constants.strImagesDir}fs_update_bk.png",
                                fit: BoxFit.fill,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: ScreenMgr.scrWidth * 0.7,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenMgr.setAdapterSize(50.0), 0.0, ScreenMgr.setAdapterSize(50.0), 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "1.版本特性版本特性",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: CusFontSize.size_14, color: Color.fromARGB(255, 102, 102, 102)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "2.版本特性版本特性版本特性版本特",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: CusFontSize.size_14, color: Color.fromARGB(255, 102, 102, 102)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "3.版本特性版本特性版本特性版本特",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: CusFontSize.size_14, color: Color.fromARGB(255, 102, 102, 102)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: ScreenMgr.setHeight(130.0),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenMgr.setAdapterSize(150.0), 0.0, ScreenMgr.setAdapterSize(150.0), 0.0),
                                  alignment: Alignment.center,
                                  child: TouchCallBack(
                                    onPressed: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Color.fromARGB(255, 88, 158, 255)),
                                      child: Text(
                                        "确认更新",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                            VSpacer(
                              ScreenMgr.setAdapterSize(50.0),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    TouchCallBack(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: ScreenMgr.setAdapterSize(150.0),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "${Constants.strImagesDir}fs_close.png",
                          scale: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  File imageFile;

  _myList(index) {
    if (this.provider.childList.length > 0) {
      return Container(
          padding: EdgeInsets.only(bottom: ScreenMgr.setHeight(50.0)),
          child: Row(children: <Widget>[
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  await RouteMgr().push(context, MyChildrenPage(this.provider.childList[index].childId)).then((value) {
                    this.provider.reqMy();
                  });
                },
                child: ClipOval(
                    child: Image.network(
                  "${this.provider.childList[index].head}",
                  fit: BoxFit.fill,
                )),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CusText(
                    "${this.provider.childList[index].username}",
                  ),
                  CusText(
                    "${this.provider.childList[index].gradeClass}",
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: ScreenMgr.setHeight(80.0),
                child: Material(
                    borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
                    color: this.provider.childList[index].isShow == 1
                        ? Color.fromARGB(255, 58, 158, 255)
                        : Color.fromARGB(255, 199, 209, 221),
                    elevation: 0.0,
                    child: new MaterialButton(
                      onPressed: () async {
                        await this.provider.reqChangeChild(this.provider.childList[index].childId);
                        setState(() {
                          this.provider.childList.forEach((item) {
                            item.isShow = 0;
                          });
                          this.provider.childList[index].isShow = 1;
                        });
                      },
                      child: CusText(
                        "默认展示",
                        color: Colors.white,
                        size: 11.0,
                      ),
                    )),
              ),
            ),
          ]));
    } else {
      return null;
    }
  }
} //end class

// class MyHomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _MyHomePageState();
//   }
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   /// 当前的进度。
//   double currentProgress = 0.6;
//   // 动画相关控制器与补间。
//   AnimationController animation;
//   Tween<double> tween;
//
//   @override
//   void initState() {
//     // AnimationController({
//     //   double value,
//     //   Duration duration,
//     //   String debugLabel,
//     //   double lowerBound: 0.0,
//     //   double upperBound: 1.0,
//     //   TickerProvider vsync
//     // })
//     // 创建动画控制器
//     animation = AnimationController(
//       // 这个动画应该持续的时间长短。
//       duration: const Duration(milliseconds: 900),
//       vsync: this,
//       // void addListener(
//       //   VoidCallback listener
//       // )
//       // 每次动画值更改时调用监听器
//       // 可以使用removeListener删除监听器
//     )..addListener(() {
//         setState(() {});
//       });
//     // Tween({T begin, T end })：创建tween（补间）
//     tween = Tween<double>(
//       begin: 0.0,
//       end: currentProgress,
//     );
//     // 开始向前运行这个动画（朝向最后）
//     animation.forward();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     animation.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO：构建页面的主要内容。
//     return Container(
//       color: Colors.white,
//       height: ScreenMgr.setAdapterSize(30.0),
//       width: ScreenMgr.scrWidth * 0.8,
//       child: Stack(
//         children: <Widget>[
//           SizedBox(
//             height: ScreenMgr.setAdapterSize(30.0),
//             width: ScreenMgr.scrWidth * 0.8,
//             // 圆角矩形剪裁（`ClipRRect`）组件，使用圆角矩形剪辑其子项的组件。
//             child: ClipRRect(
//               // 边界半径（`borderRadius`）属性，圆角的边界半径。
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               child: LinearProgressIndicator(
//                 // Animation<T> animate(
//                 //   Animation<double> parent
//                 // )
//                 // 返回一个由给定动画驱动的新动画，但它承担由该对象确定的值
//                 value: tween.animate(animation).value,
//                 backgroundColor: Color(0xffFFE3E3),
//                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF4964)),
//               ),
//             ),
//           ),
//           Container(
//             height: ScreenMgr.setAdapterSize(30.0),
//             width: ScreenMgr.scrWidth * 0.8,
//             padding: EdgeInsets.only(left: 7.0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               '已抢${(currentProgress * 100).toInt()}%',
//               style: TextStyle(
//                 color: Color(0xffFFFFFF),
//                 fontSize: 8.0,
//                 fontFamily: 'PingFangRegular',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
