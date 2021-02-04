class MyModel {
  String code;
  String msg;
  Data data;

  MyModel({this.code, this.msg, this.data});

  MyModel.fromJson(Map<String, dynamic> json) {
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
  Dtime dtime;
  List<Children> children;

  Data({this.information, this.dtime, this.children});

  Data.fromJson(Map<String, dynamic> json) {
    information = json['information'] != null
        ? new Information.fromJson(json['information'])
        : null;
    dtime = json['dtime'] != null ? new Dtime.fromJson(json['dtime']) : null;
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.information != null) {
      data['information'] = this.information.toJson();
    }
    if (this.dtime != null) {
      data['dtime'] = this.dtime.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Information {
  int id;
  String loginName;
  String username;
  String phone;
  String password;
  String gender;
  int loginStatus;
  String note;
  String lastLoginIp;
  String lastLoginTime;
  int isDelete;
  String head;
  int childId;

  Information({
    this.id,
    this.loginName,
    this.username,
    this.phone,
    this.password,
    this.gender,
    this.loginStatus,
    this.note,
    this.lastLoginIp,
    this.lastLoginTime,
    this.isDelete,
    this.head,
    this.childId,
  });

  Information.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginName = json['login_name'];
    username = json['username'];
    phone = json['phone'];
    password = json['password'];
    gender = json['gender'];
    loginStatus = json['login_status'];
    note = json['note'];
    lastLoginIp = json['last_login_ip'];
    lastLoginTime = json['last_login_time'];
    isDelete = json['is_delete'];
    head = json['head'];
    childId = json['child_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_name'] = this.loginName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['login_status'] = this.loginStatus;
    data['note'] = this.note;
    data['last_login_ip'] = this.lastLoginIp;
    data['last_login_time'] = this.lastLoginTime;
    data['is_delete'] = this.isDelete;
    data['head'] = this.head;
    data['child_id'] = this.childId;
    return data;
  }
}

class Dtime {
  String date;
  String week;

  Dtime({this.date, this.week});

  Dtime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['week'] = this.week;
    return data;
  }
}

class Children {
  int childId;
  String username;
  String gender;
  int inGrade;
  int inClass;
  int schoolId;
  String gradeClass;
  String head;
  int isShow;

  Children({
    this.childId,
    this.username,
    this.gender,
    this.inGrade,
    this.inClass,
    this.schoolId,
    this.gradeClass,
    this.head,
    this.isShow,
  });

  Children.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    username = json['username'];
    gender = json['gender'];
    inGrade = json['in_grade'];
    inClass = json['in_class'];
    schoolId = json['school_id'];
    gradeClass = json['grade_class'];
    head = json['head'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['in_grade'] = this.inGrade;
    data['in_class'] = this.inClass;
    data['school_id'] = this.schoolId;
    data['grade_class'] = this.gradeClass;
    data['head'] = this.head;
    data['is_show'] = this.isShow;
    return data;
  }
}
