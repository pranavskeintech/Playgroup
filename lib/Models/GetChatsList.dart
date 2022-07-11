class GetChatsList {
  bool? status;
  String? message;
  List<Data>? data;

  GetChatsList({this.status, this.message, this.data});

  GetChatsList.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? childId;
  String? message;
  String? files;
  String? createdDate;
  String? groupName;
  String? groupImage;
  String? childName;
  String? profile;
  String? type;

  Data(
      {this.id,
      this.childId,
      this.message,
      this.files,
      this.createdDate,
      this.groupName,
      this.groupImage,
      this.childName,
      this.profile,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['child_id'];
    message = json['message'];
    files = json['files'];
    createdDate = json['created_date'];
    groupName = json['group_name'];
    groupImage = json['group_image'];
    childName = json['child_name'];
    profile = json['profile'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_id'] = this.childId;
    data['message'] = this.message;
    data['files'] = this.files;
    data['created_date'] = this.createdDate;
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    data['type'] = this.type;
    return data;
  }
}
