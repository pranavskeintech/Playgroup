class EditChildReq {
  String? childId;
  String? parentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;

  EditChildReq(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.gender,
      this.profile});

  EditChildReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    return data;
  }
}