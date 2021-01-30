/////////////////////////////////////////////////
//广场
import 'package:family_school/pages/homework_page/fs_homework_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import '../common/common_param.dart';
import './fs_notice_details_page.dart';
import '../common/common_func.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import '../model/homework_list_model.dart';
import 'package:family_school/pages/provider/homework_list_provider.dart';
import 'fs_calendar_page.dart';

class HomeworkListPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<HomeworkListPage> with SingleTickerProviderStateMixin {
  int tabIndex = 0; // 当前选中索引
  // 选项卡控制器
  TabController _tabController;
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  HomeworkListProvider provider = HomeworkListProvider();
  String strReqTime = "";//请求数据的时间

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      this.provider.initHomework();
      this.provider.endTime = "";
      await this.provider.getHomeworkListReq();
    });

    _scrollController.addListener(() async {
      //添加监听
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        this.provider.setStateType(LoadType.en_Loading);
        await this.provider.getHomeworkListReq();
      }
    });

    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      //左右滑动时监听

      int nCurTabIndex = _tabController.index;
      setState(() {
        tabIndex = nCurTabIndex;
      });
      if (nCurTabIndex == _tabController.animation.value) {}
    });
  }

//重写被释放的方法，只释放TabController
  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            brightness: Brightness.light,
          ),
          preferredSize: Size.fromHeight(0),
        ),
        body: buildBody());
  }

  buildBody() {
    return ChangeNotifierProvider<BaseListProvider<DataInfo>>(
      create: (_) => provider,
      child: Consumer<BaseListProvider<DataInfo>>(
        builder: (_, provider, child) => Container(
          color: Colors.white,
          child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: ScreenMgr.setAdapterSize(150.0),
                      child: TabBar(
                        onTap: (value) {
                          setState(() {
                            tabIndex = value;
                          });
                        },
                        labelColor: Colors.black,
                        controller: this._tabController,
                        indicatorColor: Colors.blue,
                        indicatorPadding: EdgeInsets.fromLTRB(26.0, 0.0, 26.0, ScreenMgr.setAdapterSize(30.0)),
                        indicatorWeight: 3.2,
                        labelPadding: EdgeInsets.all(0.0),
                        tabs: <Widget>[
                          CusText(
                            '通知',
                            size: tabIndex == 0 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 0 ? Colors.black : CusColorGrey.grey400,
                          ),
                          CusText(
                            '作业',
                            size: tabIndex == 1 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 1 ? Colors.black : CusColorGrey.grey400,
                          ),
                          CusText(
                            '打卡',
                            size: tabIndex == 2 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 2 ? Colors.black : CusColorGrey.grey400,
                          ),
                          CusText(
                            '申请',
                            size: tabIndex == 3 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 3 ? Colors.black : CusColorGrey.grey400,
                          ),
                          CusText(
                            '老师',
                            size: tabIndex == 4 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 4 ? Colors.black : CusColorGrey.grey400,
                          ),
                          CusText(
                            '成绩',
                            size: tabIndex == 5 ? CusFontSize.size_18 : CusFontSize.size_15,
                            color: tabIndex == 5 ? Colors.black : CusColorGrey.grey300,
                          ),
                        ],
                      ),
                    ),
                  ),
                  showTabView()
                ],
              )),
        ),
      ),
    );
  }

  //根据 tabIndex显示对应页
  showTabView() {
    if (tabIndex == 0) {
      return buildNotice();
    } else if (tabIndex == 1) {
      return buildHomeWork();
    } else
      return SliverToBoxAdapter(child: Center(child: Text('正在开发中...')));
  }

  //通知
  buildNotice() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => TouchCallBack(
          onPressed: () {
            RouteMgr().push(context, NoticeDetailsPage());
          },
          child: Container(
            color: CusColorGrey.grey200,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              height: ScreenMgr.setAdapterSize(550.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                              child: CusText(
                                "关于提醒家长下载APP的dddddddddddddddddddddddd通知",
                                fontWeight: FontWeight.bold,
                                size: CusFontSize.size_16,
                              )),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 0,
                          child: CusText(
                            "未读",
                            color: Colors.blue,
                          ),
                        ),
                        HSpacer(
                          ScreenMgr.setAdapterSize(45.0),
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding:
                          EdgeInsets.only(left: ScreenMgr.setAdapterSize(40.0), right: ScreenMgr.setAdapterSize(40.0)),
                      child: Text(
                        "家长们收到老师发的账号密码后,第一时间下载APP并登录,将密码修改一下,以防被盗;修改密码后,将孩子的信息在app中记录一下，方便老师查看和管理,谢谢配合",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Divider(
                    color: CusColorGrey.grey300,
                    height: ScreenMgr.setAdapterSize(3.0),
                  ),
                  Expanded(
                      flex: 1,
                      child:
                          Container() /* ListTile(
                            leading: Container(),
                            title: CusText("王老师"),
                            trailing: CusText(
                              "10-12 14:02:36",
                              size: 13.0,
                              color: CusColorGrey.grey300,
                            ),
                          ),*/
                      ),
                ],
              ),
            ),
          ),
        ),
        childCount: 30,
      ),
    );
  }

  //作业
  buildHomeWork() {
    return this.provider.list.isEmpty
        ? SliverToBoxAdapter(
            child: buildHomeWordCount(),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return index < this.provider.list.length
                    ? index == 0
                        ? Column(
                            children: [
                              buildHomeWordCount(),
                              Container(
                                color: CusColorGrey.grey200,
                                child: _buildOneHomeWork(0),
                              )
                            ],
                          )
                        : Container(
                            color: CusColorGrey.grey200,
                            child: _buildOneHomeWork(index),
                          )
                    : Container(
                        color: CusColorGrey.grey200,
                        padding: EdgeInsets.fromLTRB(
                            ScreenMgr.setAdapterSize(40.0), 0.0, ScreenMgr.setAdapterSize(40.0), 0.0),
                        child: LoadMoreWidget(this.provider.stateType));
              },
              childCount: this.provider.list.length + 1,
            ),
          );
  }

  //作业数量
  buildHomeWordCount() {
    return Container(
      color: Colors.white,
      child: Container(
        height: ScreenMgr.setAdapterSize(500.0),
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
            "${Constants.strImagesDir}fs_homework_bk.png",
          )),
          borderRadius: BorderRadius.circular(10.0),
          //color: Colors.yellow
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: ScreenMgr.setAdapterSize(80.0),
                ),
                child: Row(
                  children: [
                    CusText(
                      transDateTime(_dateTime),
                      // _dateTime.toString().substring(0, 10),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () async {
                        //_showDatePicker();
                        await RouteMgr().push(context, CalendarPage()).then((value) async {
                          _dateTime = value;
                          strReqTime = "${_dateTime.year}-${_dateTime.month}-${_dateTime.day}";
                          this.provider.endTime = strReqTime;
                          this.provider.initHomework();
                          await this.provider.getHomeworkListReq();
                        });
                     /*   await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return CalendarPage();
                        })).then((value) async {
                          _dateTime = value;
                          strReqTime = "${_dateTime.year}-${_dateTime.month}-${_dateTime.day}";
                          this.provider.endTime = strReqTime;
                          this.provider.initHomework();
                          await this.provider.getHomeworkListReq();
                        });*/
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            CusText(
                              "${this.provider.totalHomework}",
                              color: Colors.white,
                              size: 30.0,
                            ),
                            CusText(
                              "总数",
                              color: Colors.white,
                            )
                          ],
                        ),
                        HSpacer(
                          ScreenMgr.setAdapterSize(20.0),
                          color: Colors.transparent,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              "${Constants.strImagesDir}fs_divide_bk.png",
                              height: ScreenMgr.setAdapterSize(200.0),
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        CusText(
                          "${this.provider.doneHomework}",
                          color: Colors.white,
                          size: 30.0,
                        ),
                        CusText(
                          "已完成",
                          color: Colors.white,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CusText(
                          "${this.provider.totalHomework - this.provider.doneHomework}",
                          color: Colors.white,
                          size: 30.0,
                        ),
                        CusText(
                          "未完成",
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //单个作业显示
  _buildOneHomeWork(int index) {
    return TouchCallBack(
      onPressed: () {
        RouteMgr().push(context, HomeWorkDetailsPage(this.provider.list[index].homeworkId));
      },
      child: Stack(
        children: [
          Container(
            height: ScreenMgr.setAdapterSize(550.0),
            margin: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(40.0), 5.0, ScreenMgr.setAdapterSize(40.0), 0.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: ScreenMgr.setAdapterSize(120.0),
                  padding: EdgeInsets.fromLTRB(ScreenMgr.setAdapterSize(150.0), 0.0, 15.0, 0.0),
                  alignment: Alignment.centerLeft,
                  child: CusText(
                    "${this.provider.list[index].homeworkName}",
                    size: CusFontSize.size_16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                showHtmlView("${this.provider.list[index].homeworkDetails}"),
                Container(
                  height: ScreenMgr.setAdapterSize(100.0),
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Row(
                    children: [
                      CusText(
                        "${this.provider.list[index].teacherName}老师 ",
                        size: CusFontSize.size_16,
                        color: CusColorGrey.grey400,
                      ),
                      CusText(
                        "${this.provider.list[index].startTime.substring(5, 19)}",
                        color: Colors.grey[400],
                        size: 14.0,
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(text: "", style: TextStyle(), children: <InlineSpan>[
                          TextSpan(
                              text: "已交：",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 137, 137, 137), fontSize: CusFontSize.size_15)),
                          TextSpan(
                              text: "${this.provider.list[index].completeCount}",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 233, 101, 21), fontSize: CusFontSize.size_15)),
                          TextSpan(
                              text: "/${this.provider.list[index].studentCount} ",
                              style:
                                  TextStyle(color: Color.fromARGB(255, 137, 137, 137), fontSize: CusFontSize.size_15)),
                          TextSpan(text: ""),
                        ]),
                      ),
                    ],
                  ),
                ),
                DottedLine(
                  color: CusColorGrey.grey200,
                ),
                Container(
                  height: ScreenMgr.setAdapterSize(130.0),
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: Row(
                    children: [
                      CusText(
                        "截止时间: ${this.provider.list[index].endTime.substring(0, 19)}",
                        color: CusColorGrey.grey400,
                      ),
                      Spacer(),
                      Container(
                        height: ScreenMgr.setHeight(100.0),
                        alignment: Alignment.center,
                        child: Material(
                            borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
                            color: this.provider.list[index].completeOwn == 0
                                ? Color.fromARGB(255, 88, 158, 255)
                                : CusColorGrey.grey300,
                            elevation: 0.0,
                            child: new MaterialButton(
                              onPressed: () {},
                              child: CusText(
                                this.provider.list[index].completeOwn == 0 ? "未提交" : "已完成",
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: ScreenMgr.setAdapterSize(30.0), top: ScreenMgr.setAdapterSize(40.0)),
              child: func_buildImageAsset("${showSubjectImg(this.provider.list[index].subjectName)}.png", dScale: 3.0))
        ],
      ),
    );
  }

  DateTime _dateTime = DateTime.now();
  _showDatePicker() {
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Container(
            height: ScreenMgr.setHeight(100.0),
            width: ScreenMgr.setAdapterSize(200.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
              color: Color.fromARGB(255, 88, 158, 255),
            ),
            child: Text('确定', style: TextStyle(color: Colors.white)),
          ),
          cancel: Container(
            height: ScreenMgr.setHeight(100.0),
            width: ScreenMgr.setAdapterSize(200.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenMgr.setAdapterSize(100.0)),
              color: Color.fromARGB(255, 200, 208, 221),
            ),
            child: Text('取消', style: TextStyle(color: Colors.white)),
          ),
        ),
        minDateTime: DateTime.parse("1980-05-21"),
        maxDateTime: DateTime.parse("2050-05-21"),
        initialDateTime: _dateTime,
        // dateFormat: "yyyy-MMMM-dd", //只包含年、月、日
        dateFormat: 'yyyy年M月d日', //  EEE,H时:m分
        pickerMode: DateTimePickerMode.datetime,
        locale: DateTimePickerLocale.zh_cn, onCancel: () {
      debugPrint("onCancel");
    }, onConfirm: (dateTime, List<int> index) {
      setState(() {
        _dateTime = dateTime;
      });
      Future.delayed(Duration.zero, () async {
        String year = _dateTime.year.toString();
        String mon;
        if (_dateTime.month < 10) {
          mon = "0${_dateTime.month}";
        } else {
          mon = "${_dateTime.month}";
        }

        String day;
        if (_dateTime.day < 10) {
          day = "0${_dateTime.day}";
        } else {
          day = "${_dateTime.day}";
        }
        strReqTime = "$year-$mon-$day";
        this.provider.endTime = strReqTime;
        this.provider.initHomework();
        await this.provider.getHomeworkListReq();
      });
    });
  }

  //根据科目返回图标
  String showSubjectImg(String str) {
    if (str == "语文") {
      return "Chinese";
    } else if (str == "数学") {
      return "Math";
    } else if (str == "英语") {
      return "English";
    } else if (str == "音乐") {
      return "Music";
    } else if (str == "科学") {
      return "Science";
    } else if (str == "体育与健康") {
      return "Sports_health";
    } else if (str == "道德与法治") {
      return "Morality_law";
    } else if (str == "美术") {
      return "Art";
    } else if (str == "信息技术") {
      return "Technology";
    } else if (str == "协作式问题解决") {
      return "problem_solving";
    }
  }
}

Widget _buildList() {
  return SliverList(
      delegate: SliverChildBuilderDelegate(
    (context, index) {
      return Container(
        height: 50,
        color: index % 2 == 0 ? Colors.white : Colors.black12,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text("我是第${index}个item"),
      );
    },
    childCount: 30,
  ));
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
