class HomeworkListModel {
  String code;
  String msg;
  Data data;

  HomeworkListModel({this.code, this.msg, this.data});

  HomeworkListModel.fromJson(Map<String, dynamic> json) {
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
  int allCount;
  int ownCount;
  Homework homework;
  List<Subjects> subjects;

  Data({this.allCount, this.ownCount, this.homework, this.subjects});

  Data.fromJson(Map<String, dynamic> json) {
    allCount = json['all_count'];
    ownCount = json['own_count'];
    homework = json['homework'] != null
        ? new Homework.fromJson(json['homework'])
        : null;
    if (json['subjects'] != null) {
      subjects = new List<Subjects>();
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_count'] = this.allCount;
    data['own_count'] = this.ownCount;
    if (this.homework != null) {
      data['homework'] = this.homework.toJson();
    }
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Homework {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<DataInfo> data;

  Homework(
      {this.total, this.perPage, this.currentPage, this.lastPage, this.data});

  Homework.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = new List<DataInfo>();
      json['data'].forEach((v) {
        data.add(new DataInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataInfo {
  int homeworkId;
  String homeworkName;
  String homeworkDetails;
  String startTime;
  String endTime;
  String teacherName;
  int subjectId;
  String subjectName;
  int completeCount;
  int studentCount;
  int completeOwn;

  DataInfo(
      {this.homeworkId,
        this.homeworkName,
        this.homeworkDetails,
        this.startTime,
        this.endTime,
        this.teacherName,
        this.subjectId,
        this.subjectName,
        this.completeCount,
        this.studentCount,
        this.completeOwn});

  DataInfo.fromJson(Map<String, dynamic> json) {
    homeworkId = json['homework_id'];
    homeworkName = json['homework_name'];
    homeworkDetails = json['homework_details'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    teacherName = json['teacher_name'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    completeCount = json['complete_count'];
    studentCount = json['student_count'];
    completeOwn = json['complete_own'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homework_id'] = this.homeworkId;
    data['homework_name'] = this.homeworkName;
    data['homework_details'] = this.homeworkDetails;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['teacher_name'] = this.teacherName;
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['complete_count'] = this.completeCount;
    data['student_count'] = this.studentCount;
    data['complete_own'] = this.completeOwn;
    return data;
  }
}

class Subjects {
  int id;
  String name;
  int schoolId;

  Subjects({this.id, this.name, this.schoolId});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    schoolId = json['school_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['school_id'] = this.schoolId;
    return data;
  }
}
