class UserDetailsRes {
  bool? status;
  String? message;
  List<UserData>? data;

  UserDetailsRes({this.status, this.message, this.data});

  UserDetailsRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? userId;
  String? parentName;
  String? emailId;
  String? phone;
  String? location;

  UserData({this.userId, this.parentName, this.emailId, this.phone, this.location});

  UserData.fromJson(Map<String, dynamic> json) {
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
