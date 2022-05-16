class AddChildReq {
  String? parentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;

  AddChildReq(
      {this.parentId, this.childName, this.dob, this.gender, this.profile});

  AddChildReq.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    return data;
  }
}
