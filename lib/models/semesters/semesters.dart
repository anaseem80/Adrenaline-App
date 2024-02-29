class Semesters {
  String? message;
  List<Data>? data;
  int? statusCode;

  Semesters({this.message, this.data, this.statusCode});

  Semesters.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  int? collegeYearId;
  String? semesterName;
  Null? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
        this.collegeYearId,
        this.semesterName,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collegeYearId = json['college_year_id'];
    semesterName = json['semester_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['college_year_id'] = this.collegeYearId;
    data['semester_name'] = this.semesterName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
