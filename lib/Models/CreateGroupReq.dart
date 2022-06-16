class CreateGroupReq {
  String? groupName;
  String? groupImage;
  List<int>? groupMembers;

  CreateGroupReq({this.groupName, this.groupImage, this.groupMembers});

  CreateGroupReq.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
    groupImage = json['group_image'];
    groupMembers = json['group_members'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    data['group_members'] = this.groupMembers;
    return data;
  }
}
