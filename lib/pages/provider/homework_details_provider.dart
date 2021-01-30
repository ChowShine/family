//作业详情

import 'package:family_school/pages/common/common_param.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../model/homework_details_model.dart';
import 'package:dio/dio.dart';

class HomeWorkDetailsProvider extends BaseProvider<HomeworkDetailModel> {
  bool isHaveSend=false;//已经发送过作业
  bool isComment=false;//老师是否点评
  bool isCanModify=false;

  Future<void> getHomeworkDetailsReq(int homeworkId) async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}student_homework_details",
          params: {"homework_id": homeworkId});
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        HomeworkDetailModel model=HomeworkDetailModel.fromJson(mpData);
        isHaveSend=((model?.data?.submitOrNot??0)==0)?false:true;
        isComment=((model?.data?.studentHomework?.isRemark??0)==0)?false:true;
        isCanModify=((model?.data?.studentHomework?.modifyOrNot??0)==0)?false:true;
        this.setData(model);
      }
    } catch (e) {
      print("$e");
    }
  }

  //删除作业
 static  Future<String> getDelHomeworkReq(int fileId) async {
    try {
      Response resp = await Constants.httpFamilyToken.postRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}del_file",
          params: {"file_id": fileId});
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        if(mpData!=null){
          return mpData["msg"];
        }else{
          return Future.value("网络返回出错");
        }
      }else{
        return Future.value("网络请求出错");
      }
    } catch (e) {
      print("$e");
      return Future.value("网络请求异常");
    }
  }

}
