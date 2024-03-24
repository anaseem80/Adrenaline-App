class InstructorModel {
  String? message;
  List<Data>? data;
  int? statusCode;

  InstructorModel({this.message, this.data, this.statusCode});

  InstructorModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? lastname;
  String? email;
  String? title;
  String? emailVerifiedAt;
  String? role;
  String? country;
  String? browserToken;
  int? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? profilePhotoUrl;
  List<Reviews>? reviews;
  // List<Null>? courses;

  Data(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.title,
        this.emailVerifiedAt,
        this.role,
        this.country,
        this.browserToken,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.deviceToken,
        this.profilePhotoUrl,
        this.reviews,
        // this.courses
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    title = json['title'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    country = json['country'];
    browserToken = json['browser_token'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceToken = json['device_token'];
    profilePhotoUrl = json['profile_photo_url'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    // if (json['courses'] != null) {
    //   courses = <Null>[];
    //   json['courses'].forEach((v) {
    //     courses!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['title'] = this.title;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['country'] = this.country;
    data['browser_token'] = this.browserToken;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['device_token'] = this.deviceToken;
    data['profile_photo_url'] = this.profilePhotoUrl;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    // if (this.courses != null) {
    //   data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Reviews {
  int? id;
  int? courseId;
  int? userId;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
        this.courseId,
        this.userId,
        this.rating,
        this.review,
        this.createdAt,
        this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
