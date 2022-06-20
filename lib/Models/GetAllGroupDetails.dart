class GetAllGroupDetailsRes {
  bool? status;
  String? message;
  List<GroupDetails>? groupDetails;

  GetAllGroupDetailsRes({this.status, this.message, this.groupDetails});

  GetAllGroupDetailsRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['groupDetails'] != null) {
      groupDetails = <GroupDetails>[];
      json['groupDetails'].forEach((v) {
        groupDetails!.add(new GroupDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.groupDetails != null) {
      data['groupDetails'] = this.groupDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupDetails {
  int? groupParticipantsId;
  int? groupId;
  int? childId;
  String? groupAccess;
  String? muteConversation;
  String? mediaVisibility;
  String? groupName;
  int? createdBy;
  String? groupImage;
  String? groupSetting;
  String? createdOn;

  GroupDetails(
      {this.groupParticipantsId,
      this.groupId,
      this.childId,
      this.groupAccess,
      this.muteConversation,
      this.mediaVisibility,
      this.groupName,
      this.createdBy,
      this.groupImage,
      this.groupSetting,
      this.createdOn});

  GroupDetails.fromJson(Map<String, dynamic> json) {
    groupParticipantsId = json['group_participants_id'];
    groupId = json['group_id'];
    childId = json['child_id'];
    groupAccess = json['group_access'];
    muteConversation = json['mute_conversation'];
    mediaVisibility = json['media_visibility'];
    groupName = json['group_name'];
    createdBy = json['created_by'];
    groupImage = json['group_image'];
    groupSetting = json['group_setting'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_participants_id'] = this.groupParticipantsId;
    data['group_id'] = this.groupId;
    data['child_id'] = this.childId;
    data['group_access'] = this.groupAccess;
    data['mute_conversation'] = this.muteConversation;
    data['media_visibility'] = this.mediaVisibility;
    data['group_name'] = this.groupName;
    data['created_by'] = this.createdBy;
    data['group_image'] = this.groupImage;
    data['group_setting'] = this.groupSetting;
    data['created_on'] = this.createdOn;
    return data;
  }
}
