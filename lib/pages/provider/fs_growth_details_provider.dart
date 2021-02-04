
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import 'package:family_school/pages/model/fs_growth_details_model.dart';
import 'package:dio/dio.dart';
import '../common/common_param.dart';

class DetailsProvider extends BaseProvider<DetailsModel> {
  List<DataName> detailsList = [];
  Future<void> getDetails(projectId) async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}green_report_list",
          params: {'project_id': projectId, 'limit': 100, 'page': 1});
      Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
      print(resp);
      var myModelData = DetailsModel.fromJson(mpData);
      if (resp.data != null) {
        detailsList = myModelData.data.dataName;
      }
    } catch (e) {
      print("$e");
    }
    notifyListeners();
  }
}
