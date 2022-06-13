class GetNotificationListRes {
  bool? status;
  String? message;
  List<Data>? data;

  GetNotificationListRes({this.status, this.message, this.data});

  GetNotificationListRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? notificationId;
  int? childId;
  String? title;
  String? body;
  String? createdDate;

  Data(
      {this.notificationId,
      this.childId,
      this.title,
      this.body,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    childId = json['child_id'];
    title = json['title'];
    body = json['body'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['child_id'] = this.childId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['created_date'] = this.createdDate;
    return data;
  }
}
