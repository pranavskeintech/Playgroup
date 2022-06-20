class GroupsAndFriends {
  bool? status;
  String? message;
  List<GroupDetai>? data;

  GroupsAndFriends({this.status, this.message, this.data});

  GroupsAndFriends.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GroupDetai>[];
      json['data'].forEach((v) {
        data!.add(new GroupDetai.fromJson(v));
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

class GroupDetai {
  int? friendsId;
  int? childId;
  int? childFriendId;
  String? requestStatus;
  String? createdDate;
  String? childName;
  String? profile;
  int? groupId;
  String? groupName;
  int? createdBy;
  Null? groupDescription;
  String? groupImage;
  String? groupSetting;
  String? createdOn;
  String? updatedOn;

  GroupDetai(
      {this.friendsId,
      this.childId,
      this.childFriendId,
      this.requestStatus,
      this.createdDate,
      this.childName,
      this.profile,
      this.groupId,
      this.groupName,
      this.createdBy,
      this.groupDescription,
      this.groupImage,
      this.groupSetting,
      this.createdOn,
      this.updatedOn});

  GroupDetai.fromJson(Map<String, dynamic> json) {
    friendsId = json['friends_id'];
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    requestStatus = json['request_status'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    createdBy = json['created_by'];
    groupDescription = json['group_description'];
    groupImage = json['group_image'];
    groupSetting = json['group_setting'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friends_id'] = this.friendsId;
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['request_status'] = this.requestStatus;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['created_by'] = this.createdBy;
    data['group_description'] = this.groupDescription;
    data['group_image'] = this.groupImage;
    data['group_setting'] = this.groupSetting;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}
