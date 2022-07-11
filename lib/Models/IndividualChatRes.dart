class IndividualChatRes {
  List<IndiData>? data;

  IndividualChatRes({this.data});

  IndividualChatRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <IndiData>[];
      json['data'].forEach((v) {
        data!.add(new IndiData.fromJson(v));
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

class IndiData {
  int? chatId;
  int? childId;
  int? otherChildId;
  String? message;
  String? files;
  String? readStatus;
  String? softDelete;
  String? createdDate;
  String? childName;
  String? profile;

  IndiData(
      {this.chatId,
      this.childId,
      this.otherChildId,
      this.message,
      this.files,
      this.readStatus,
      this.softDelete,
      this.createdDate,
      this.childName,
      this.profile});

  IndiData.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    childId = json['child_id'];
    otherChildId = json['other_child_id'];
    message = json['message'];
    files = json['files'];
    readStatus = json['read_status'];
    softDelete = json['soft_delete'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['child_id'] = this.childId;
    data['other_child_id'] = this.otherChildId;
    data['message'] = this.message;
    data['files'] = this.files;
    data['read_status'] = this.readStatus;
    data['soft_delete'] = this.softDelete;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
