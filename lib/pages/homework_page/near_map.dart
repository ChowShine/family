/*
//附近位置

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';
import 'package:dio/adapter.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/pages/component/touch_callback.dart';

class NearMapPage extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<NearMapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    _controller.addListener(() {
      if(_controller.position.pixels==_controller.position.maxScrollExtent){
        onLoadMore();
        setState(() {

        });
      }
    });
  }

  init() async {
    /////////////////flutter定位
    await AMapLocationClient.startup(
        new AMapLocationOption(desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    getLocation();
  }

  AMapLocation currentAddressInfo = AMapLocation(); //当前位置的信息
  TextEditingController searchController = TextEditingController(); //搜索关键字控制器
//  List<model> modelList = [];
  int pageSize = 20; //一页大小
  int pageIndex = 1; //当前页
  int pages = 1; //总页数
  List<PeripheralInformationPoi> pois=[]; //返回页面显示的数据集合
  String androidAMapKey = "fef4e35be05e2337119aeb3b4e57388d"; //安卓高德key 搜索POI需要
  bool cityLimit = true; //仅返回指定城市数据
  getLocation() async {
    // 申请权限 定位权限
    var status = await Permission.location.status;
    print('PermissionStatus.granted${status.isGranted}');
    if (status.isGranted) {
      await AMapLocationClient.getLocation(true).then((_) async{
        print('获取定位成功');
        print('获取的latitude${_.latitude}');
        print('获取的longitude${_.longitude}');

        showToast("定位成功");
        currentAddressInfo = _; //获取到当前定位的信息
        await aroundHttp();
        setState(() {

        });
      });
    } else {
      showToast("权限申请被拒绝");
      Map<Permission, PermissionStatus> status = await [Permission.location].request();
    }
  }

  final ScrollController _controller=new ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await Navigator.pop(context,currentAddressInfo.POIName??"");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('附近信息',style: TextStyle(color: Colors.black),),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              //搜索框
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //当前城市
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(right: 5),
                          child: Row(
                            children: <Widget>[
                              TouchCallBack(

                                child: Container(
                                  child: Text(
                                    '当前所在位置：${currentAddressInfo.POIName ?? "   "}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pop(context,currentAddressInfo.POIName ?? "   ");
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //点击跳转到选择城市页面
                        },
                      ),
                      //线
*/
/*                    Container(
                        width: 1,
                        color: Colors.grey[400],
                        margin: EdgeInsets.symmetric(vertical: 9),
                      ),
                      //输入框
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "点击输入",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                              border: InputBorder.none,
                            ),
                            controller: searchController,
                            onSubmitted: (val) {
                              //调用搜索接口
                              if (val == null || val == "" || val.length == 0) {
                                return;
                              } else {
                                print('调用搜索接口');
                                searchHttp();
                              }
                            },
                            onChanged: (val) {
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.55,
                        ),
                      ),
                      //搜索按钮
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Center(
                              child: Text(
                                '搜索',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.17,
                            decoration: BoxDecoration(color: Color(0xff2EA5F1), borderRadius: BorderRadius.circular(2)),
                          ),
                          onTap: () {
                            //调用搜索接口
                            print('调用搜索接口');
                            searchHttp();
                          },
                        ),
                      ),*//*

                    ],
                  ),
                  decoration: BoxDecoration(color: Color(0xffF0F0F0), borderRadius: BorderRadius.circular(4)),
                ),
              ),
              //数据列表
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: RefreshIndicator(
                      child: ListView(
                        controller: _controller,
                        children: List.generate(pois.length, (index) {
                          return InkWell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 12, bottom: 10, top: 10),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  Container(
                                    width: 3,
                                  ),
                                  Expanded(
                                      child: Text(
                                    '${pois[index].name}',
                                    style: TextStyle(fontSize: 13, color: Color(0xff333333)),
                                    softWrap: true,
                                  )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[100], width: 1),
                              ),
                            ),
                            onTap: () {
                              //获取数据返回
                              Navigator.pop(context,'${pois[index].name}');
                            },
                          );
                        }),
                      ),
                      //todo:刷新
                      onRefresh: () async {
                        print('下拉刷新');
                        //searchHttp();
                      },
                      //todo:加载更多
                   */
/*   onLoad: () async {
                        print('加载更多');
                        onLoadMore();
                      },*//*

                    )),
              )
            ],
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  //调用接口
  Future<Null> searchHttp() async {
    pois = [];
    PeripheralInformationEntity locationInformationEntity = await searchForHttp(1);
    if (locationInformationEntity.status == "1") {
      print('请求成功');
      pageIndex = 1;
      pois = locationInformationEntity.pois;
      int total = int.parse(locationInformationEntity.count);
      //整页
      if (total % pageSize == 0) {
        pages = (total / pageSize).floor();
      } else {
        pages = (total / pageSize).floor() + 1;
      }
      setState(() {});
    } else {
      showToast("请求失败");
    }
  }


  //加载更多
  Future<Null> onLoadMore() async {
    if (pageIndex < pages) {
      PeripheralInformationEntity locationInformationEntity = await searchForHttp(pageIndex + 1);
      if (locationInformationEntity.status == "1") {
        print('请求成功');
        pageIndex++;
        pois.addAll(locationInformationEntity.pois);
      } else {
        showToast("请求失败");
      }
    } else {
      showToast("没有更多数据了");
    }
  }

  //高德接口获取周边数据---不使用插件
  aroundHttp() async {
    PeripheralInformationEntity locationInformationEntity = await aroundForHttp();
    if (locationInformationEntity.status == "1") {
      print('请求成功');
      pois = locationInformationEntity.pois;
      int total = int.parse(locationInformationEntity.count); //总数量
      //算页数
      if (total % pageSize == 0) {
        pages = (total / pageSize).floor();
      } else {
        pages = (total / pageSize).floor() + 1;
      }
    } else {
      showToast("没有更多数据了");
    }
  }

  //高德接口搜索---不使用插件
  Future<PeripheralInformationEntity> searchForHttp(pageIndex) async {
    String BaseUrl = "https://restapi.amap.com/v3/place/text";
    Map<String, dynamic> map = Map();
    map["key"] = androidAMapKey;
    map["keywords"] = searchController.text;
    map["city"] = currentAddressInfo.city; //搜索的城市
    map["offset"] = pageSize; //每页记录数据
    map["page"] = pageIndex; //每页记录数据
    map["citylimit"] = cityLimit; //仅返回指定城市数据
    Response resp = await Http.getInstance()
        .dio
        .get(
          BaseUrl,
          queryParameters: map,
        )
        .catchError((e) {
      print(e);
    });

    PeripheralInformationEntity baseBean = PeripheralInformationEntity.fromJson(resp.data);
    return baseBean;
  }

  //高德接口获取当前位置周边信息---不使用插件
  Future<PeripheralInformationEntity> aroundForHttp() async {
    String BaseUrl = "https://restapi.amap.com/v3/place/around";
    Map<String, dynamic> map = Map();
    map["key"] = androidAMapKey;
    map["keywords"] = searchController.text;
    map["city"] = currentAddressInfo.city; //搜索的城市
    map["location"] =
        "${currentAddressInfo.longitude},${currentAddressInfo.latitude}"; //中心点坐标 经度和纬度用","分割，经度在前，纬度在后，经纬度小数点后不得超过6位
    map["offset"] = pageSize; //每页记录数据
    map["page"] = pageIndex; //每页记录数据
    map["citylimit"] = cityLimit; //仅返回指定城市数据
    Response resp = await Http.getInstance()
        .dio
        .get(
          BaseUrl,
          queryParameters: map,
        )
        .catchError((e) {
      print(e);
    });
    PeripheralInformationEntity baseBean = PeripheralInformationEntity.fromJson(resp.data);
    return baseBean;
  }
}

class PeripheralInformationEntity {
  PeripheralInformationSuggestion suggestion;
  String count;
  String infocode;
  List<PeripheralInformationPoi> pois;
  String status;
  String info;

  PeripheralInformationEntity({this.suggestion, this.count, this.infocode, this.pois, this.status, this.info});

  PeripheralInformationEntity.fromJson(Map<String, dynamic> json) {
    suggestion = json['suggestion'] != null ? new PeripheralInformationSuggestion.fromJson(json['suggestion']) : null;
    count = json['count'];
    infocode = json['infocode'];
    if (json['pois'] != null) {
      pois = new List<PeripheralInformationPoi>();
      (json['pois'] as List).forEach((v) {
        pois.add(new PeripheralInformationPoi.fromJson(v));
      });
    }
    status = json['status'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suggestion != null) {
      data['suggestion'] = this.suggestion.toJson();
    }
    data['count'] = this.count;
    data['infocode'] = this.infocode;
    if (this.pois != null) {
      data['pois'] = this.pois.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['info'] = this.info;
    return data;
  }
}

class PeripheralInformationSuggestion {
  List<Null> keywords;
  List<Null> cities;

  PeripheralInformationSuggestion({this.keywords, this.cities});

  PeripheralInformationSuggestion.fromJson(Map<String, dynamic> json) {
    if (json['keywords'] != null) {
      keywords = new List<Null>();
    }
    if (json['cities'] != null) {
      cities = new List<Null>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keywords != null) {
      data['keywords'] = [];
    }
    if (this.cities != null) {
      data['cities'] = [];
    }
    return data;
  }
}

class PeripheralInformationPoi {
  List<Null> parent;
  dynamic address;
  List<Null> distance;
  PeripheralInformationPoisBizExt bizExt;
  String pname;
  List<Null> importance;
  List<Null> bizType;
  String cityname;
  String type;
  List<PeripheralInformationPoisPhoto> photos;
  String typecode;
  String shopinfo;
  List<Null> poiweight;
  List<Null> childtype;
  String adname;
  String name;
  String location;
  String tel;
  List<Null> shopid;
  String id;

  PeripheralInformationPoi(
      {this.parent,
      this.address,
      this.distance,
      this.bizExt,
      this.pname,
      this.importance,
      this.bizType,
      this.cityname,
      this.type,
      this.photos,
      this.typecode,
      this.shopinfo,
      this.poiweight,
      this.childtype,
      this.adname,
      this.name,
      this.location,
      this.tel,
      this.shopid,
      this.id});

  PeripheralInformationPoi.fromJson(Map<String, dynamic> json) {
    if (json['parent'] != null) {
      parent = new List<Null>();
    }
    address = json['address'];
    if (json['distance'] != null) {
      distance = new List<Null>();
    }
    bizExt = json['biz_ext'] != null ? new PeripheralInformationPoisBizExt.fromJson(json['biz_ext']) : null;
    pname = json['pname'];
    cityname = json['cityname'];
    type = json['type'];
    typecode = json['typecode'];
    shopinfo = json['shopinfo'];
    adname = json['adname'];
    name = json['name'];
    location = json['location'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parent != null) {
      data['parent'] = [];
    }
    data['address'] = this.address;
    if (this.distance != null) {
      data['distance'] = [];
    }
    if (this.bizExt != null) {
      data['biz_ext'] = this.bizExt.toJson();
    }
    data['pname'] = this.pname;
    if (this.importance != null) {
      data['importance'] = [];
    }
    if (this.bizType != null) {
      data['biz_type'] = [];
    }
    data['cityname'] = this.cityname;
    data['type'] = this.type;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['typecode'] = this.typecode;
    data['shopinfo'] = this.shopinfo;
    if (this.poiweight != null) {
      data['poiweight'] = [];
    }
    if (this.childtype != null) {
      data['childtype'] = [];
    }
    data['adname'] = this.adname;
    data['name'] = this.name;
    data['location'] = this.location;
    data['tel'] = this.tel;
    if (this.shopid != null) {
      data['shopid'] = [];
    }
    data['id'] = this.id;
    return data;
  }
}

class PeripheralInformationPoisBizExt {
  List<Null> cost;
  String rating;

  PeripheralInformationPoisBizExt({this.cost, this.rating});

  PeripheralInformationPoisBizExt.fromJson(Map<String, dynamic> json) {
    if (json['cost'] != null) {
      cost = new List<Null>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cost != null) {
      data['cost'] = [];
    }
    data['rating'] = this.rating;
    return data;
  }
}

class PeripheralInformationPoisPhoto {
  List<Null> provider;
  List<Null> title;
  String url;

  PeripheralInformationPoisPhoto({this.provider, this.title, this.url});

  PeripheralInformationPoisPhoto.fromJson(Map<String, dynamic> json) {
    if (json['provider'] != null) {
      provider = new List<Null>();
    }
    if (json['title'] != null) {
      title = new List<Null>();
    }
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provider != null) {
      data['provider'] = [];
    }
    if (this.title != null) {
      data['title'] = [];
    }
    data['url'] = this.url;
    return data;
  }
}

class Config {
//  String base_url = "http://chenhongye1.qicp.io:55118";
  String base_url = "https://restapi.amap.com/v3/place/text";
  int connectTimeout = 60000;
  int receiveTimeout = 60000;
}
*/
/**
 * 通过网络请求工具
 *//*


class Http {
  static Http instance;
  static String token;
  Config _config = new Config();
  Dio _dio;

  static Http getInstance() {
    if (instance == null) {
      instance = new Http();
    }
    return instance;
  }

  Http() {
    // 初始化 Options
    _dio = new Dio();
    _dio.options.baseUrl = _config.base_url;
    _dio.options.connectTimeout = _config.connectTimeout;
    _dio.options.receiveTimeout = _config.receiveTimeout;
    //https证书校验
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情
      Map<String, dynamic> _headers = options.headers ?? {};
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      print("================== 响应数据 ==========================");
      print("statusCode：${response.statusCode}");
      print("response.data：${response.data}");
      return response;
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return e; //continue
    }));
  }

  Dio get dio {
    return _dio;
  }
}
*/
