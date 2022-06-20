class GetGroupDetailsByIdRes {
  bool? status;
  String? message;
  List<GroupDetails>? groupDetails;
  List<GroupMembers>? groupMembers;

  GetGroupDetailsByIdRes(
      {this.status, this.message, this.groupDetails, this.groupMembers});

  GetGroupDetailsByIdRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['groupDetails'] != null) {
      groupDetails = <GroupDetails>[];
      json['groupDetails'].forEach((v) {
        groupDetails!.add(new GroupDetails.fromJson(v));
      });
    }
    if (json['groupMembers'] != null) {
      groupMembers = <GroupMembers>[];
      json['groupMembers'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
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
    if (this.groupMembers != null) {
      data['groupMembers'] = this.groupMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupDetails {
  int? groupId;
  String? groupName;
  int? createdBy;
  Null? groupDescription;
  String? groupImage;
  String? groupSetting;
  String? createdOn;
  String? updatedOn;

  GroupDetails(
      {this.groupId,
      this.groupName,
      this.createdBy,
      this.groupDescription,
      this.groupImage,
      this.groupSetting,
      this.createdOn,
      this.updatedOn});

  GroupDetails.fromJson(Map<String, dynamic> json) {
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

class GroupMembers {
  int? childId;
  String? childName;
  String? gender;
  String? profile;
  String? school;
  int? parentId;

  GroupMembers(
      {this.childId,
      this.childName,
      this.gender,
      this.profile,
      this.school,
      this.parentId});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childName = json['child_name'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_name'] = this.childName;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    data['parent_id'] = this.parentId;
    return data;
  }
}
