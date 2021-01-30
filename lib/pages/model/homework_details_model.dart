class HomeworkDetailModel {
  String code;
  String msg;
  Data data;

  HomeworkDetailModel({this.code, this.msg, this.data});

  HomeworkDetailModel.fromJson(Map<String, dynamic> json) {
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
  String homeworkName;
  String teacherName;
  int inGrade;
  int inClass;
  String startTime;
  String endTime;
  String homeworkDetails;
  String gradeClass;
  List<Files> files;
  int submitOrNot;
  StudentHomework studentHomework;
  List<Score> score;

  Data(
      {this.homeworkName,
        this.teacherName,
        this.inGrade,
        this.inClass,
        this.startTime,
        this.endTime,
        this.homeworkDetails,
        this.gradeClass,
        this.files,
        this.submitOrNot,
        this.studentHomework,
        this.score});

  Data.fromJson(Map<String, dynamic> json) {
    homeworkName = json['homework_name'];
    teacherName = json['teacher_name'];
    inGrade = json['in_grade'];
    inClass = json['in_class'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    homeworkDetails = json['homework_details'];
    gradeClass = json['grade_class'];
    if (json['files'] != null) {
      files = new List<Files>();
      json['files'].forEach((v) {
        files.add(new Files.fromJson(v));
      });
    }
    submitOrNot = json['submit_or_not'];
    studentHomework = json['student_homework'] != null
        ? new StudentHomework.fromJson(json['student_homework'])
        : null;
    if (json['score'] != null) {
      score = new List<Score>();
      json['score'].forEach((v) {
        score.add(new Score.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homework_name'] = this.homeworkName;
    data['teacher_name'] = this.teacherName;
    data['in_grade'] = this.inGrade;
    data['in_class'] = this.inClass;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['homework_details'] = this.homeworkDetails;
    data['grade_class'] = this.gradeClass;
    if (this.files != null) {
      data['files'] = this.files.map((v) => v.toJson()).toList();
    }
    data['submit_or_not'] = this.submitOrNot;
    if (this.studentHomework != null) {
      data['student_homework'] = this.studentHomework.toJson();
    }
    if (this.score != null) {
      data['score'] = this.score.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String address;

  Files({this.address});

  Files.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}

class StudentHomework {
  int id;
  int studentId;
  int homeWorkId;
  String content;
  String dtime;
  int isShow;
  int isRemark;
  int remarkId;
  String remark;
  int schoolId;
  int scoreId;
  String remarkTime;
  int modifyOrNot;
  String scoreName;
  List<RemarkFile> remarkFile;
  List<StudentFiles> studentFiles;

  StudentHomework(
      {this.id,
        this.studentId,
        this.homeWorkId,
        this.content,
        this.dtime,
        this.isShow,
        this.isRemark,
        this.remarkId,
        this.remark,
        this.schoolId,
        this.scoreId,
        this.remarkTime,
        this.modifyOrNot,
        this.scoreName,
        this.remarkFile,
        this.studentFiles});

  StudentHomework.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    homeWorkId = json['home_work_id'];
    content = json['content'];
    dtime = json['dtime'];
    isShow = json['is_show'];
    isRemark = json['is_remark'];
    remarkId = json['remark_id'];
    remark = json['remark'];
    schoolId = json['school_id'];
    scoreId = json['score_id'];
    remarkTime = json['remark_time'];
    modifyOrNot = json['modify_or_not'];
    scoreName = json['score_name'];
    if (json['remark_file'] != null) {
      remarkFile = new List<RemarkFile>();
      json['remark_file'].forEach((v) {
        remarkFile.add(new RemarkFile.fromJson(v));
      });
    }
    if (json['student_files'] != null) {
      studentFiles = new List<StudentFiles>();
      json['student_files'].forEach((v) {
        studentFiles.add(new StudentFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['home_work_id'] = this.homeWorkId;
    data['content'] = this.content;
    data['dtime'] = this.dtime;
    data['is_show'] = this.isShow;
    data['is_remark'] = this.isRemark;
    data['remark_id'] = this.remarkId;
    data['remark'] = this.remark;
    data['school_id'] = this.schoolId;
    data['score_id'] = this.scoreId;
    data['remark_time'] = this.remarkTime;
    data['modify_or_not'] = this.modifyOrNot;
    data['score_name'] = this.scoreName;
    if (this.remarkFile != null) {
      data['remark_file'] = this.remarkFile.map((v) => v.toJson()).toList();
    }
    if (this.studentFiles != null) {
      data['student_files'] = this.studentFiles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemarkFile {
  int remarkFileId;
  String address;
  String voiceTime;

  RemarkFile({this.remarkFileId, this.address, this.voiceTime});

  RemarkFile.fromJson(Map<String, dynamic> json) {
    remarkFileId = json['remark_file_id'];
    address = json['address'];
    voiceTime = json['voice_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark_file_id'] = this.remarkFileId;
    data['address'] = this.address;
    data['voice_time'] = this.voiceTime;
    return data;
  }
}

class StudentFiles {
  int studentFilesId;
  String studentFilesAddress;

  StudentFiles({this.studentFilesId, this.studentFilesAddress});

  StudentFiles.fromJson(Map<String, dynamic> json) {
    studentFilesId = json['student_files_id'];
    studentFilesAddress = json['student_files_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_files_id'] = this.studentFilesId;
    data['student_files_address'] = this.studentFilesAddress;
    return data;
  }
}

class Score {
  int id;
  String scoreName;

  Score({this.id, this.scoreName});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scoreName = json['score_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['score_name'] = this.scoreName;
    return data;
  }
}
