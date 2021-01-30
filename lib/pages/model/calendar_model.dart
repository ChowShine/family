//日历
class CalendarModel {
  String code;
  String msg;
  List<Data> data;

  CalendarModel({this.code, this.msg, this.data});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int date;
  bool haveHomework;

  Data({this.date, this.haveHomework});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    haveHomework = json['have_homework'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['have_homework'] = this.haveHomework;
    return data;
  }
}
