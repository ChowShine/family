class MyChildrenModel {
  String code;
  String msg;
  Data data;

  MyChildrenModel({this.code, this.msg, this.data});

  MyChildrenModel.fromJson(Map<String, dynamic> json) {
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
  String classJob;

  Data(
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
        this.isShow,
        this.classJob,
      });

  Data.fromJson(Map<String, dynamic> json) {
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
    classJob = json['class_job'];
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
    data['class_job'] = this.classJob;
    return data;
  }
}