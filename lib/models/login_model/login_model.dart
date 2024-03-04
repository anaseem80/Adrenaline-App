class LoginModel{
  String? message;
  String? token;
  UserLogin? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('user')){
      data = UserLogin.fromJson(json['user']);
      token = json['token'];
    }else{
      data = null;
      message = json['message'];
    }
  }
}

class UserLogin {
  int? id;
  String? email;
  String? firstname;
  String? lastname;
  String? user_picture;
  UserLogin.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.firstname = json['firstname'];
    this.lastname = json['lastname'];
    this.email = json['email'];
    this.user_picture = json['profile_photo_path'];
  }
}