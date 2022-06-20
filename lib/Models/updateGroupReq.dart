class updateGroupReq {
  String? groupName;
  String? groupImage;

  updateGroupReq({this.groupName, this.groupImage});

  updateGroupReq.fromJson(Map<String, dynamic> json) {
    groupName = json['group_name'];
    groupImage = json['group_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    return data;
  }
}
