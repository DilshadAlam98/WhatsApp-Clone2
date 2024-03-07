class LoginModel {
  String? firstName;
  String? lastName;
  String? mobile;
  String? about;
  String? uuid;
  String? email;

  LoginModel({
    this.firstName,
    this.lastName,
    this.mobile,
    this.about,
    this.uuid,
    required this.email,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    about = json['about'];
    uuid = json['uuid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['about'] = about;
    data['uuid'] = uuid;
    data['email'] = email;
    return data;
  }
}
