class Register_Res {
  bool? status;
  String? message;
  int? userId;
  String? token;
  RefreshToken? refreshToken;

  Register_Res(
      {this.status, this.message, this.userId, this.token, this.refreshToken});

  Register_Res.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    token = json['token'];
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['token'] = this.token;
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
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
