
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import 'package:family_school/pages/model/fs_my_children_model.dart';
import 'package:dio/dio.dart';
import '../common/common_param.dart';
import 'package:oktoast/oktoast.dart';

class MyChildrenProvider extends BaseProvider<MyChildrenModel> {
  Data childData;
  Future<void> reqCheckChild(childId) async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}my_child",
          params: {"child_id": childId});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      this.setData(MyChildrenModel.fromJson(mpData));
      var myModelData = MyChildrenModel.fromJson(mpData).data;
      if (resp != null) {
        childData = myModelData;
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }

  Future<void> reqDelChild(childId) async {
    try {
      Response resp = await Constants.httpFamilyToken.postRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}del_child",
          params: {"child_id": childId});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      if (mpData['code'] == '0') {
        showToast('删除成功!');
      } else {
        showToast('修改失败!');
      }
      notifyListeners();
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }
}
