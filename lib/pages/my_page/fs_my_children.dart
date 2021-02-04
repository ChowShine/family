//我的孩子

import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/customMgr/dlgMgr.dart';
import '../common/common_param.dart';
import 'file:///D:/work/003007_yt_videochat_app_flutter/trunk/apps/family_school/lib/pages/provider/fs_my_provide.dart';
import 'package:family_school/pages/provider/fs_my_children_provider.dart';
import 'package:family_school/pages/model/fs_my_children_model.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:provider/provider.dart';

class MyChildrenPage extends StatefulWidget {
  final int id; //学生Id
  MyChildrenPage(this.id);
  @override
  _MyChildrenPageState createState() => _MyChildrenPageState();
}

class _MyChildrenPageState extends State<MyChildrenPage> {
  MyProvider provider = MyProvider();
  MyChildrenProvider myChildrenProvider = MyChildrenProvider();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      await this.myChildrenProvider.reqCheckChild(widget.id);
    });
    print('1111');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop("");
        return Future.value(true);
      },
      child: Scaffold(
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
      ),
    );
  }

  _buildBody() {
    return ChangeNotifierProvider<BaseProvider<MyChildrenModel>>(
        create: (_) => myChildrenProvider,
        child: Consumer<BaseProvider<MyChildrenModel>>(
            builder: (_, provider, child) => this.myChildrenProvider.childData ==
                    null
                ? LoadingDialog()
                : SingleChildScrollView(
                    child: Container(
                      height: ScreenMgr.scrHeight -
                          ScreenMgr.statusBarHeight -
                          kToolbarHeight,
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
                                  ClipOval(
                                      child: Image.network(
                                    "${this.myChildrenProvider.childData?.head ?? ''}",
                                    fit: BoxFit.fill,
                                  )),
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
                                  "${this.myChildrenProvider.childData?.username ?? ''}",
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
                                  this.myChildrenProvider.childData?.gender ==
                                          '0'
                                      ? "男"
                                      : (this
                                                      .myChildrenProvider
                                                      .childData
                                                      ?.gender ==
                                                  '1'
                                              ? "女"
                                              : '' ?? '') ??
                                          '',
                                  // this.myChildrenProvider.childData?.gender ?? '',
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
                                CusText("年级", size: CusFontSize.size_17),
                                Spacer(),
                                CusText(
                                  "${this.myChildrenProvider.childData?.inGrade ?? ''}年级",
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
                                  "${this.myChildrenProvider.childData?.inClass ?? ''}班",
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
                                  "${this.myChildrenProvider.childData?.classJob ?? ''}",
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
                                      borderRadius: BorderRadius.circular(
                                          ScreenMgr.setAdapterSize(100.0)),
                                      color: Color.fromARGB(255, 194, 113, 112),
                                      child: new MaterialButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return new AlertDialog(
                                                  title: new Text("提示"),
                                                  content:
                                                      new Text('确定删除我的孩子吗？'),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      onPressed: () async {
                                                        await this
                                                            .myChildrenProvider
                                                            .reqDelChild(
                                                                widget.id);
                                                        Navigator.of(context)
                                                          ..pop()
                                                          ..pop();
                                                      },
                                                      child: new Text("确认"),
                                                    ),
                                                    new FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: new Text("取消"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
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
                                      borderRadius: BorderRadius.circular(
                                          ScreenMgr.setAdapterSize(100.0)),
                                      color: this
                                                  .myChildrenProvider
                                                  .childData
                                                  ?.isShow ==
                                              1
                                          ? Color.fromARGB(255, 58, 158, 255)
                                          : Color.fromARGB(
                                                  255, 199, 209, 221) ??
                                              '',
                                      child: new MaterialButton(
                                        onPressed: () async {
                                          await this
                                              .provider
                                              .reqChangeChild(widget.id);
                                          setState(() {
                                            this
                                                .myChildrenProvider
                                                .childData
                                                .isShow = 1;
                                            Navigator.of(context).pop();
                                          });
                                        },
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
                    ),
                  )));
  }
} //end_class
