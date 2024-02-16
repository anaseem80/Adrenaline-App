class ActiveUser{
  ActiveUserModel? data;
  ActiveUser.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('user')){
      data = ActiveUserModel.fromJson(json['user']);
    }else{
      data = null;
    }

  }
}


class ActiveUserModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  ActiveUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }
}