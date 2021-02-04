class GrowthModel {
  String code;
  String msg;
  Data data;

  GrowthModel({this.code, this.msg, this.data});

  GrowthModel.fromJson(Map<String, dynamic> json) {
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
  Information information;
  Message message;
  int allScore;

  Data({this.information, this.message, this.allScore});

  Data.fromJson(Map<String, dynamic> json) {
    information = json['information'] != null
        ? new Information.fromJson(json['information'])
        : null;
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    allScore = json['all_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.information != null) {
      data['information'] = this.information.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    data['all_score'] = this.allScore;
    return data;
  }
}

class Information {
  int id;
  String loginName;
  String username;
  String password;
  String identification;
  String gender;
  int loginStatus;
  int inGrade;
  int inClass;
  String note;
  int lastLoginIp;
  String lastLoginTime;
  int isDelete;
  String phone;
  int groupId;
  int schoolId;
  int parentId;
  String head;
  int isShow;

  Information(
      {this.id,
        this.loginName,
        this.username,
        this.password,
        this.identification,
        this.gender,
        this.loginStatus,
        this.inGrade,
        this.inClass,
        this.note,
        this.lastLoginIp,
        this.lastLoginTime,
        this.isDelete,
        this.phone,
        this.groupId,
        this.schoolId,
        this.parentId,
        this.head,
        this.isShow});

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginName = json['login_name'];
    username = json['username'];
    password = json['password'];
    identification = json['identification'];
    gender = json['gender'];
    loginStatus = json['login_status'];
    inGrade = json['in_grade'];
    inClass = json['in_class'];
    note = json['note'];
    lastLoginIp = json['last_login_ip'];
    lastLoginTime = json['last_login_time'];
    isDelete = json['is_delete'];
    phone = json['phone'];
    groupId = json['group_id'];
    schoolId = json['school_id'];
    parentId = json['parent_id'];
    head = json['head'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_name'] = this.loginName;
    data['username'] = this.username;
    data['password'] = this.password;
    data['identification'] = this.identification;
    data['gender'] = this.gender;
    data['login_status'] = this.loginStatus;
    data['in_grade'] = this.inGrade;
    data['in_class'] = this.inClass;
    data['note'] = this.note;
    data['last_login_ip'] = this.lastLoginIp;
    data['last_login_time'] = this.lastLoginTime;
    data['is_delete'] = this.isDelete;
    data['phone'] = this.phone;
    data['group_id'] = this.groupId;
    data['school_id'] = this.schoolId;
    data['parent_id'] = this.parentId;
    data['head'] = this.head;
    data['is_show'] = this.isShow;
    return data;
  }
}

class Message {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<DataName> dataName;

  Message(
      {this.total, this.perPage, this.currentPage, this.lastPage, this.dataName});

  Message.fromJson(Map<String, dynamic> json) {
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
  int projectId;
  String projectsName;
  String stationName;
  int score;
  int detailsId;
  String learnCardName;
  String semesterName;
  int schoolId;
  String address;

  DataName(
      {this.projectId,
        this.projectsName,
        this.stationName,
        this.score,
        this.detailsId,
        this.learnCardName,
        this.semesterName,
        this.schoolId,
        this.address});

  DataName.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectsName = json['projects_name'];
    stationName = json['station_name'];
    score = json['score'];
    detailsId = json['details_id'];
    learnCardName = json['learn_card_name'];
    semesterName = json['semester_name'];
    schoolId = json['school_id'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['projects_name'] = this.projectsName;
    data['station_name'] = this.stationName;
    data['score'] = this.score;
    data['details_id'] = this.detailsId;
    data['learn_card_name'] = this.learnCardName;
    data['semester_name'] = this.semesterName;
    data['school_id'] = this.schoolId;
    data['address'] = this.address;
    return data;
  }
}

