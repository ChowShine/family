
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import 'package:family_school/pages/model/fs_growth_process_model.dart';
import 'package:dio/dio.dart';
import '../common/common_param.dart';

class GrowthProvider extends BaseProvider<GrowthModel> {
  List<DataName> projectsList = [];
  int allScore;
  String username;
  Future<void> getGrowth() async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}green_report",
          params: {'limit': 100, 'page': 1});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      print(resp);
      var myModelData = GrowthModel.fromJson(mpData);
      if (resp != null) {
        projectsList = myModelData?.data?.message?.dataName ?? [];
        allScore = myModelData?.data?.allScore ?? 0;
        username = myModelData?.data?.information?.username ?? '';
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }
}
