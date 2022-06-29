class EditChildReq {
  int? childId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? school;

  EditChildReq(
      {this.childId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.school});

  EditChildReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    return data;
  }
}
