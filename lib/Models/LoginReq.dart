class LoginReq {
  String? emailId;
  String? password;

  LoginReq({this.emailId, this.password});

  LoginReq.fromJson(Map<String, dynamic> json) {
    emailId = json['email_id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    return data;
  }
}
