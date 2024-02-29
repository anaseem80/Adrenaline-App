class CollageYears {
  String? message;
  List<Data>? data;
  int? statusCode;

  CollageYears({this.message, this.data, this.statusCode});

  CollageYears.fromJson(Map<String, dynamic> json) {
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
  int? collegeId;
  int? yearNumber;
  Null? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
        this.collegeId,
        this.yearNumber,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collegeId = json['college_id'];
    yearNumber = json['year_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['college_id'] = this.collegeId;
    data['year_number'] = this.yearNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
