//日历页面
import 'package:flutter/material.dart';
import 'package:videochat_package/constants/customMgr/widgetMgr.dart';
import 'package:videochat_package/constants/customMgr/screenMgr.dart';
import '../common/common_param.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:provider/provider.dart';
import '../model/calendar_model.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import '../provider/calendar_provider.dart';
import '../common/common_func.dart';
import 'package:videochat_package/constants/customMgr/datetimeMgr.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> lsWeeks = [];
  List<bool> lsIsSelect = List.filled(37, false);//是否选择
  int nYear = DateTime.now().year;
  int nMonth = DateTime.now().month;
  int nStart = 0; //lsHaveHomework 存储数据索引,之前全部为false
  List<bool> lsHaveHomework = List.filled(37, false); //第一天不一定是周一，那么也从周一开始存储，数据为不可用
  CalendarProvider provider = CalendarProvider();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //this.provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<BaseProvider<CalendarModel>>(
        create: (_) => provider,
        child: Consumer<BaseProvider<CalendarModel>>(
          builder: (_, provider, child) => Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 93, 162, 255),
              ),
              CusPadding(
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: ScreenMgr.setAdapterSize(150.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              lsCalendar.length,
                              (index) => CusText(
                                    "${lsCalendar[index]}",
                                    color: CusColorGrey.grey500,
                                  )),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenMgr.setAdapterSize(20.0), 0.0, ScreenMgr.setAdapterSize(20.0), 0.0),
                        child: buildWeek(lsWeeks),
                      ))
                    ],
                  ),
                ),
                l: ScreenMgr.setAdapterSize(30.0),
                r: ScreenMgr.setAdapterSize(30.0),
                t: ScreenMgr.setAdapterSize(300.0),
              ),
              CusPadding(
                Row(
                  children: [
                    //HSpacer(ScreenMgr.setAdapterSize(100.0)),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.chevron_left_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        DateTime dt = DateTime.now();
                        //String  ret= "${dt.year}-${dt.month}-${dt.day}";
                        Navigator.pop(context,dt);
                      },
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (nMonth > 1)
                          nMonth--;
                        else {
                          //下一年
                          nYear--;
                          nMonth = 12;
                        }
                        nStart = 0;
                        lsIsSelect = List.filled(37, false);
                        getData();
                      },
                      child: func_buildImageAsset("fs_left_arrow.png"),
                    ),
                    HSpacer(ScreenMgr.setAdapterSize(30.0)),
                    CusText(
                      "$nYear年$nMonth月",
                      color: Colors.white,
                      size: CusFontSize.size_17,
                    ),
                    HSpacer(ScreenMgr.setAdapterSize(30.0)),
                    InkWell(
                      onTap: () {
                        if (nMonth < 12)
                          nMonth++;
                        else {
                          //下一年
                          nYear++;
                          nMonth = 1;
                        }
                        nStart = 0;
                        lsIsSelect = List.filled(37, false);
                        getData();
                      },
                      child: func_buildImageAsset("fs_right_arrow.png"),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Constants.log.v("${_selectDay()}", tag: "选择日期");
                        Navigator.pop(context,_selectDay());
                      },
                      child: CusText(
                        "确定",
                        color: Colors.white,
                        size: CusFontSize.size_17,
                      ),
                    ),
                    HSpacer(ScreenMgr.setAdapterSize(100.0))
                  ],
                ),
                t: ScreenMgr.setAdapterSize(60.0),
                b: ScreenMgr.scrHeight - ScreenMgr.setAdapterSize(300.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  getData() {
    int days = _getMonthDays(nYear, nMonth);
    int week = _getMonthFirstDayWeek(nYear, nMonth);
    lsWeeks = doWeek(days, week);
    Constants.log.v("$days", tag: "天数");
    Constants.log.v("$week", tag: "星期");

    for (int i = 0; i < lsWeeks.length; i++) {
      DateTime dt = DateTime.now();
      if (lsWeeks[i] == dt.day.toString() && nYear == dt.year && nMonth == dt.month) {
        lsIsSelect[i] = true;
        break;
      }
    }

    Future.delayed(Duration.zero, () async {
      await provider.getCalendarReq("$nYear-$nMonth");
      if (this.provider.instance?.data != null && this.provider.instance.data.isNotEmpty) {
        int i = nStart;
        Constants.log.v("${this.provider.instance.data.length}");
        Constants.log.v("$nStart", tag: "开始索引");
        this.provider.instance.data.forEach((element) {
          lsHaveHomework[i] = element.haveHomework;
          i++;
        });
      }
    });
  }

  _selectDay() {
    int nSelIndex = -1;
    for (int i = 0; i < lsIsSelect.length; i++) {
      if (lsIsSelect[i]) {
        nSelIndex = i;
        break;
      }
    }
    if (nSelIndex != -1) {//返回选择日期
      return DateTime(nYear,nMonth,int.parse(lsWeeks[nSelIndex]));
    } else {//返回当天
      return DateTime.now();
    }
  }

  //得到某个月天数
  _getMonthDays(int year, int month) {
    return DateTimeMgr().getMonthDays(year,month);
  }

  //得到某个月第一天星期几[1,2,3....,7]
  _getMonthFirstDayWeek(int year, int month) {
   return DateTimeMgr().getMonthFirstDayWeek(year, month);
  }

  // 最多37个 （ 1号在周日，有31天）
  //  一  二  三  四  五  六  日
  //  ""  ""  ""  1   2   3   4
  //  5   6   7   8   9   10  11
  //  .........................
  //  30  31

  doWeek(int totalDay, int firstDayWeek) {
    List<String> lsWeek = [];
    for (int i = 1; i < firstDayWeek; i++) {
      lsWeek.add("");
      lsHaveHomework[i - 1] = false;
      nStart++;
    }
    for (int i = 1; i <= totalDay; i++) {
      lsWeek.add("$i");
    }
    return lsWeek;
  }

  buildWeek(List<String> lsStr) {
    assert(lsStr != null && lsStr.isNotEmpty);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            setState(() {
              if (lsWeeks[index] != "") {
                if (!lsIsSelect[index]) {
                  lsIsSelect[index] = !lsIsSelect[index];
                  for (int i = 0; i < lsIsSelect.length; i++) {
                    if (lsIsSelect[i] && i != index) lsIsSelect[i] = false;
                  }
                } else {
                  lsIsSelect[index] = false;
                }
              }
            });
          },
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                height: ScreenMgr.setAdapterSize(80.0),
                width: ScreenMgr.setAdapterSize(80.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lsIsSelect[index] ? Color.fromARGB(255, 93, 162, 255) : Colors.white),
                child: CusText("${lsStr[index]}",
                    size: CusFontSize.size_17, color: lsIsSelect[index] ? Colors.white : Colors.black),
              ),
              Visibility(
                //底下小圆圈
                visible: lsHaveHomework[index],
                child: Container(
                  height: 4.0,
                  width: 4.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 93, 162, 255)),
                ),
              )
            ],
          )),
        );
      },
      itemCount: lsStr.length,
    );
  }

  //日期 是否是今天
  isToday(String year, String month, String day) {
    if (day == DateTime.now().day.toString() &&
        month == DateTime.now().month.toString() &&
        year == DateTime.now().year.toString())
      return true;
    else
      return false;
  }
} //end_class
