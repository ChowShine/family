import 'package:dio/dio.dart';
import 'package:videochat_package/constants/constants.dart';
import 'package:videochat_package/constants/token/family_token.dart';
import '../common/common_param.dart';
import 'package:videochat_package/constants/base/base_provider.dart';
import '../model/calendar_model.dart';

class CalendarProvider extends BaseProvider<CalendarModel> {

  Future<void> getCalendarReq(String data) async {
    try {
      Response resp = await Constants.httpFamilyToken.getRequest(
          "${gnNetType == 0 ? URL.API_ADDRESS : URLIntranet.API_ADDRESS}student_homework_daily",
          params: {"month": data});
      if (resp != null) {
        Map<String, dynamic> mpData = Map<String, dynamic>.from(resp.data);
        CalendarModel model = CalendarModel.fromJson(mpData);
        this.setData(model);
      }
    } catch (e) {
      print("$e");
    }
  }
}
