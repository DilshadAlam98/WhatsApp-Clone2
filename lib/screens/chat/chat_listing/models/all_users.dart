class AllUsers {
  String? firstName;
  String? lastName;
  String? mobile;
  String? about;
  String? uuid;

  AllUsers({
    this.firstName,
    this.lastName,
    this.mobile,
    this.about,
    this.uuid,
  });

  AllUsers.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    about = json['about'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['about'] = about;
    data['uuid'] = uuid;
    return data;
  }
}
