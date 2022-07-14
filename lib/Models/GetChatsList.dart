class GetChatsList {
  bool? status;
  String? message;
  List<ChatListData>? data;

  GetChatsList({this.status, this.message, this.data});

  GetChatsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatListData>[];
      json['data'].forEach((v) {
        data!.add(new ChatListData.fromJson(v));
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

class ChatListData {
  int? id;
  int? childId;
  String? groupName;
  String? groupImage;
  String? message;
  String? senderName;
  String? createdDate;
  String? type;
  String? childName;
  String? profile;

  ChatListData(
      {this.id,
      this.childId,
      this.groupName,
      this.groupImage,
      this.message,
      this.senderName,
      this.createdDate,
      this.type,
      this.childName,
      this.profile});

  ChatListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['child_id'];
    groupName = json['group_name'];
    groupImage = json['group_image'];
    message = json['message'];
    senderName = json['sender_name'];
    createdDate = json['created_date'];
    type = json['type'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_id'] = this.childId;
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    data['message'] = this.message;
    data['sender_name'] = this.senderName;
    data['created_date'] = this.createdDate;
    data['type'] = this.type;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
