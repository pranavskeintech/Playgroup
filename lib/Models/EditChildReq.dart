class EditChildReq {
  int? childId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  List<int>? childInterest;
  String? school;
  List<String>? language;

  EditChildReq(
      {this.childId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.childInterest,
      this.school,
      this.language});

  EditChildReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    childInterest = json['child_interest'].cast<int>();
    school = json['school'];
    language = json['language'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['child_interest'] = this.childInterest;
    data['school'] = this.school;
    data['language'] = this.language;
    return data;
  }
}
