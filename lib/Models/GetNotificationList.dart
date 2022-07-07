class GetNotificationListRes {
  bool? status;
  String? message;
  List<Data>? data;
  int? unreadNotification;

  GetNotificationListRes(
      {this.status, this.message, this.data, this.unreadNotification});

  GetNotificationListRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    unreadNotification = json['total_unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total_unread'] = this.unreadNotification;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? notificationId;
  int? childId;
  int? otherChildId;
  int? markavailId;
  String? title;
  String? body;
  String? status;
  String? markavailStatus;
  String? createdDate;

  Data(
      {this.notificationId,
      this.childId,
      this.otherChildId,
      this.markavailId,
      this.title,
      this.body,
      this.status,
      this.markavailStatus,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    childId = json['child_id'];
    otherChildId = json['other_child_id'];
    markavailId = json['markavail_id'];
    title = json['title'];
    body = json['body'];
    status = json['status'];
    markavailStatus = json['markavail_status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['child_id'] = this.childId;
    data['other_child_id'] = this.otherChildId;
    data['markavail_id'] = this.markavailId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['status'] = this.status;
    data['markavail_status'] = this.markavailStatus;
    data['created_date'] = this.createdDate;
    return data;
  }
}
