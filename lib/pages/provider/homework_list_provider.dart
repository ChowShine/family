//作业列表
import 'dart:io';

import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/customMgr/httpMgr.dart';
import '../model/homework_list_model.dart';
import 'package:dio/dio.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../common/common_param.dart';

class HomeworkListProvider extends BaseListProvider<DataInfo> {
  int totalHomework = 0;
  int doneHomework = 0; //已完成


  String endTime = "";

  initHomework() {
    totalHomework = 0;
    this.init();
  }

  Future<void> getHomeworkListReq() async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}student_homework_list",
          params: {"limit": this.limit, "page": this.page, "end_time": endTime});
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        HomeworkListModel model = HomeworkListModel.fromJson(mpData);
        List<DataInfo> dataInfo = model?.data?.homework?.data ?? [];
        totalHomework = model?.data?.allCount ?? 0;
        doneHomework = model?.data?.ownCount ?? 0;
        if (dataInfo.isNotEmpty) {
          this.addAll(dataInfo);
          this.setPage();
        } else {
          setStateType(LoadType.en_LoadComplete);
        }
        Future.delayed(Duration(milliseconds: 500), () {
          setStateType(LoadType.en_LoadNormal);
        });
      }
    } catch (e) {
      print("$e");
    }
    this?.notifyListeners();
  }

  //提交作业
  static Future<String> sendHomeworkReq(List<File> lsFile, int id, String content) async {
    Map<String, dynamic> formDataMap = await HttpMgr().getFormDataMap(lsFile, {"homework_id": id, "content": content});

    FormData formData = FormData.fromMap(formDataMap);

    try {
      Response resp = await Constants.httpFamilyToken.postRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}hand_the_homework",
          params: formData);
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        if (mpData != null) {
          return Future.value("${mpData["msg"]}");
        } else {
          return Future.value("网页返回出错");
        }
      } else {
        //网络请求出错
        return Future.value("网络请求出错");
      }
    } catch (e) {
      print("$e");
      return Future.value("网络请求异常");
    }
  }
}
