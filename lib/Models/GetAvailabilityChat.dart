class GetAvailabilityChat {
  List<AvailChatData>? data;

  GetAvailabilityChat({this.data});

  GetAvailabilityChat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AvailChatData>[];
      json['data'].forEach((v) {
        data!.add(new AvailChatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailChatData {
  int? markAvailChatId;
  int? markavailId;
  int? childId;
  String? message;
  String? files;
  String? softDelete;
  String? createdDate;
  String? childName;
  String? profile;

  AvailChatData(
      {this.markAvailChatId,
      this.markavailId,
      this.childId,
      this.message,
      this.files,
      this.softDelete,
      this.createdDate,
      this.childName,
      this.profile});

  AvailChatData.fromJson(Map<String, dynamic> json) {
    markAvailChatId = json['mark_avail_chat_id'];
    markavailId = json['markavail_id'];
    childId = json['child_id'];
    message = json['message'];
    files = json['files'];
    softDelete = json['soft_delete'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mark_avail_chat_id'] = this.markAvailChatId;
    data['markavail_id'] = this.markavailId;
    data['child_id'] = this.childId;
    data['message'] = this.message;
    data['files'] = this.files;
    data['soft_delete'] = this.softDelete;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
