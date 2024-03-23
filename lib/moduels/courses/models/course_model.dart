class CourseModel {
  String? message;
  List<Data>? data;
  int? statusCode;

  CourseModel({this.message, this.data, this.statusCode});

  CourseModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  String? image;
  String? type;
  int? price;
  int? priceEn;
  int? priceAr;
  int? semesterId;
  String? createdAt;
  String? updatedAt;
  int? free;
  int? createdBy;
  Null? moduleId;
  int? isArchived;
  String? rate;
  int? discountAr;
  int? discountEn;
  Owner? owner;

  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.type,
        this.price,
        this.priceEn,
        this.priceAr,
        this.semesterId,
        this.createdAt,
        this.updatedAt,
        this.free,
        this.createdBy,
        this.moduleId,
        this.isArchived,
        this.rate,
        this.discountAr,
        this.discountEn,
        this.owner});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    type = json['type'];
    price = json['price'];
    priceEn = json['price_en'];
    priceAr = json['price_ar'];
    semesterId = json['semester_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    free = json['free'];
    createdBy = json['created_by'];
    moduleId = json['module_id'];
    isArchived = json['is_archived'];
    rate = json['rate'];
    discountAr = json['discount_ar'];
    discountEn = json['discount_en'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['type'] = this.type;
    data['price'] = this.price;
    data['price_en'] = this.priceEn;
    data['price_ar'] = this.priceAr;
    data['semester_id'] = this.semesterId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['free'] = this.free;
    data['created_by'] = this.createdBy;
    data['module_id'] = this.moduleId;
    data['is_archived'] = this.isArchived;
    data['rate'] = this.rate;
    data['discount_ar'] = this.discountAr;
    data['discount_en'] = this.discountEn;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  Null? title;
  Null? emailVerifiedAt;
  String? role;
  Null? country;
  Null? browserToken;
  Null? currentTeamId;
  String? profilePhotoPath;
  Null? createdAt;
  Null? updatedAt;
  Null? deviceToken;
  String? profilePhotoUrl;

  Owner(
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
        this.profilePhotoUrl});

  Owner.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}