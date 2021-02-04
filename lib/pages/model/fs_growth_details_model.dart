class DetailsModel {
  String code;
  String msg;
  Data data;

  DetailsModel({this.code, this.msg, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<DataName> dataName;

  Data({this.total, this.perPage, this.currentPage, this.lastPage, this.dataName});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      dataName = new List<DataName>();
      json['data'].forEach((v) {
        dataName.add(new DataName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    if (this.dataName != null) {
      data['data'] = this.dataName.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataName {
  int msgId;
  int studentId;
  int score;
  String semesterName;
  List<Address> address;

  DataName(
      {this.msgId,
        this.studentId,
        this.score,
        this.semesterName,
        this.address});

  DataName.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    studentId = json['student_id'];
    score = json['score'];
    semesterName = json['semester_name'];
    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    data['student_id'] = this.studentId;
    data['score'] = this.score;
    data['semester_name'] = this.semesterName;
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String address;

  Address({this.address});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}