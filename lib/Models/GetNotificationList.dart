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
  int? otherChildId;
  int? markavailId;
  String? title;
  String? body;
  String? createdDate;
  int? markAvailId;

  Data(
      {this.notificationId,
      this.childId,
      this.otherChildId,
      this.markavailId,
      this.title,
      this.body,
      this.createdDate,
      this.markAvailId});

  Data.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    childId = json['child_id'];
    otherChildId = json['other_child_id'];
    markavailId = json['markavail_id'];
    title = json['title'];
    body = json['body'];
    createdDate = json['created_date'];
    markAvailId = json['mark_avail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['child_id'] = this.childId;
    data['other_child_id'] = this.otherChildId;
    data['markavail_id'] = this.markavailId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['created_date'] = this.createdDate;
    data['mark_avail_id'] = this.markAvailId;
    return data;
  }
}
