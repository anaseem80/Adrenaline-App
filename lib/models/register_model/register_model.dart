class RegisterModel{
  String? message;
  String? token;
  dynamic? errors;
  RegisterUser? data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('user')){
      data = RegisterUser.fromJson(json['user']);
      token = json['token'];
    }else{
      token = null;
    }
    if(json.containsKey('errors')){
      errors = json['errors'];
    }else{
      errors = null;
    }
  }
}

class RegisterUser {
  String? email;
  String? firstname;
  String? lastname;
  String? user_picture;
  RegisterUser.fromJson(Map<String, dynamic> json) {
    this.firstname = json['firstname'];
    this.lastname = json['lastname'];
    this.email = json['email'];
    this.user_picture = json['profile_photo_path'];
  }
}