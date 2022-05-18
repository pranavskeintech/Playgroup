class LoginRes {
  bool? status;
  String? message;
  String? token;
  RefreshToken? refreshToken;
  List<Data>? data;

  LoginRes(
      {this.status, this.message, this.token, this.refreshToken, this.data});

  LoginRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefreshToken {
  String? refreshToken;
  String? expires;

  RefreshToken({this.refreshToken, this.expires});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refreshToken'] = this.refreshToken;
    data['expires'] = this.expires;
    return data;
  }
}

class Data {
  int? userId;
  String? parentName;
  String? emailId;
  String? phone;
  String? location;

  Data({this.userId, this.parentName, this.emailId, this.phone, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    parentName = json['parent_name'];
    emailId = json['email_id'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['parent_name'] = this.parentName;
    data['email_id'] = this.emailId;
    data['phone'] = this.phone;
    data['location'] = this.location;
    return data;
  }
}
