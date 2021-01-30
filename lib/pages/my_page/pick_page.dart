import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:city_pickers/city_pickers.dart';
//7个选择器：年龄、学历、婚姻、身高、收入、工作、地址选择

//https://blog.csdn.net/iOS_PING/article/details/102567294
//第1个 选择年龄18-55
class AgePick {
  BuildContext context;
  AgePick({this.context}) {
    for (int i = 18; i < 55; i++) pickerChildren.add(i.toString());
  }

  List pickerChildren = [];
  int selectedValue = 0;
  String selectedAge = "";
//选择性别
  Widget _buildAgePicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择性别：${pickerChildren[value]}");
        print("$value");
        //setState(() {
        selectedValue = value;
        //});
      },
      children: pickerChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择年龄
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedAge() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedAge = pickerChildren[selectedValue];
                        Navigator.pop(context, selectedAge); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildAgePicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/////////////////////////////////////////////////////////////////////////
//第2个 教育
class EducationPick {
  BuildContext context;
  EducationPick({this.context});

  List _pickChildren = List()..add("高中及以下")..add("大专")..add("本科")..add("硕士及以上");

  int selectedValue = 0;
  String selectedEducation = "";
//选择学历
  Widget _buildEducationPicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择学历：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择学历
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedEducation() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedEducation = _pickChildren[selectedValue];
                        Navigator.pop(context, selectedEducation); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildEducationPicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

///////////////////////////////////////////////////////////////////////
//第3个 婚姻
class MarriagePick {
  BuildContext context;
  MarriagePick({this.context});

  List _pickChildren = List()..add("未婚")..add("已婚")..add("离异");

  int selectedValue = 0;
  String selectedMarriage = "";
//选择婚姻
  Widget _buildMarriagePicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择婚姻：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择婚姻
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedMarriage() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedMarriage = _pickChildren[selectedValue];
                        Navigator.pop(context, selectedMarriage); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildMarriagePicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

///////////////////////////////////////////////////////////////////////
//第4个 身高140-200cm
class HighPick {
  BuildContext context;
  HighPick({this.context}){
    for(int i=140;i<200;i++){
      _pickChildren.add(i.toString());
    }

  }

  List _pickChildren = List();

  int selectedValue = 0;
  String selectedHigh = "";
//选择身高
  Widget _buildHighPicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择身高：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择身高
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedHigh() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedHigh = _pickChildren[selectedValue];
                        Navigator.pop(context, selectedHigh); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildHighPicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

///////////////////////////////////////////////////////////////////////
//第5个 收入
class IncomePick {
  BuildContext context;
  IncomePick({this.context});

  List _pickChildren = List()..add("2000-3000元")..add("3000-4000元")..add("4000-5000元")
  ..add("5000-6000元")..add("6000-7000元")..add("7000-8000元")..add("8000-9000元")..add("9000-10000元")
    ..add("10000元及以上");

  int selectedValue = 0;
  String selectedIncome = "";
//选择收入
  Widget _buildIncomePicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择收入：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择收入
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedIncome() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedIncome = _pickChildren[selectedValue];
                        Navigator.pop(context, selectedIncome); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildIncomePicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

//////////////////////////////////////////////////////////////////////
//第6个 职业
class WorkPick {
  BuildContext context;
  WorkPick({this.context});

  List _pickChildren = List()..add("农、林、牧、渔、水利业")..add("工业")..add("地质普查和勘探业")
    ..add("建筑业")..add("交通运输业、邮电通信业")..add("商业、公共饮食业、物资供应和仓储业")
    ..add("房地产管理、公用事业")
    ..add("居民服务和咨询服务业")
    ..add("卫生、体育和社会福利事业")
    ..add("教育、文化艺术和广播电视业")
    ..add("科学研究和综合技术服务业")
    ..add("金融、保险业")
    ..add("国家机关、党政机关和社会团体")
    ..add("其他行业");

  int selectedValue = 0;
  String selectedWork = "";
//选择职业
  Widget _buildWorkPicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择职业：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  /*function  点击选择职业
   *param
   *return 确定返回选择的值，取消返回空
   */
  Future<String> didClickSelectedIncome() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, ""); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedWork= _pickChildren[selectedValue];
                        Navigator.pop(context, selectedWork); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildWorkPicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/////////////////////////////////////////////////////////////////////
//第7个 地址
class CityPick{
  BuildContext context;
  CityPick({this.context});

  Result resultArr = new Result();
  //没有选 返回null，选择返回result
  Future<Result> didClickSelectedCity(BuildContext context) async {
    Result tempResult = await CityPickers.showCityPicker(
        context: context,
        theme: Theme.of(context).copyWith(primaryColor: Colors.black),
        // 设置主题
        //locationCode: resultArr != null ? resultArr.areaId ?? resultArr.cityId ?? resultArr.provinceId : null,
        // 初始化地址信息
        cancelWidget: Text(
          '取消',
          style: TextStyle(color: Colors.black),
        ),
        confirmWidget: Text(
          '确定',
          style: TextStyle(color: Colors.black),
        ),
        height: 220.0
    );

    if (tempResult != null) {
      return tempResult;
    }else{
      return null;
    }
  }
}


//年龄范围
class AgeScopePick {
  BuildContext context;
  AgeScopePick({this.context});

  List _pickChildren = List()..add("18-25")..add("25-35")..add("35-45")..add("45-55");

  int selectedValue = 0;
  String selectedMarriage = "";
//选择年龄
  Widget _buildMarriagePicker() {
    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (value) {
        print("选择年龄：${_pickChildren[value]}");
        print("$value");
        selectedValue = value;
      },
      children: _pickChildren.map((data) {
        return Text(data);
      }).toList(),
    );
  }

  Future<String> didClickSelectedAgeScope() async {
    selectedValue = 0;
    return await showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context); //取消返回空
                      },
                      child: Text(
                        "取消",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        selectedMarriage = _pickChildren[selectedValue];
                        Navigator.pop(context, selectedMarriage); //确定返回选择的值
                      },
                      child: Text(
                        "确定",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildMarriagePicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}







