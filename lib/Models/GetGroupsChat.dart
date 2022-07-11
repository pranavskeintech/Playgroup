class GetGroupsChat {
  List<Data>? data;

  GetGroupsChat({this.data});

  GetGroupsChat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? groupChatId;
  int? groupId;
  int? childId;
  String? message;
  String? files;
  Null? softDelete;
  String? createdDate;
  String? childName;
  String? profile;

  Data(
      {this.groupChatId,
      this.groupId,
      this.childId,
      this.message,
      this.files,
      this.softDelete,
      this.createdDate,
      this.childName,
      this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    groupChatId = json['group_chat_id'];
    groupId = json['group_id'];
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
    data['group_chat_id'] = this.groupChatId;
    data['group_id'] = this.groupId;
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
