
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import 'package:family_school/pages/model/fs_my_model.dart';
import 'package:dio/dio.dart';
import '../common/common_param.dart';
import 'package:oktoast/oktoast.dart';

class MyProvider extends BaseProvider<MyModel> {
  Information myData;
  List<Children> childList = [];
  Future<void> reqMy() async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}parent_mine",
          params: {});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      var myModelData = MyModel.fromJson(mpData).data;
      if (resp != null) {
        myData = myModelData.information;
        childList = myModelData.children;
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }

  Future<void> reqChangeChild(childId) async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}change_child",
          params: {"child_id": childId});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      if (mpData['code'] == '0') {
        showToast('修改成功，需要重新登录才能生效！');
      } else {
        showToast('修改失败！');
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }

  Future<void> reqAddChild(inviteCode) async {
    try {
      Response resp = await Constants.httpFamilyToken.postRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}add_child",
          params: {"invite_code": inviteCode});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      if (mpData['code'] == '0') {
        showToast(mpData['msg']);
      } else {
        showToast(mpData['msg']);
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }
}

