class UserRegisterReq {
  String? parentName;
  String? emailId;
  String? password;
  String? phone;
  String? location;

  UserRegisterReq(
      {this.parentName,
      this.emailId,
      this.password,
      this.phone,
      this.location});

  UserRegisterReq.fromJson(Map<String, dynamic> json) {
    parentName = json['parent_name'];
    emailId = json['email_id'];
    password = json['password'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_name'] = this.parentName;
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['location'] = this.location;
    return data;
  }
}
