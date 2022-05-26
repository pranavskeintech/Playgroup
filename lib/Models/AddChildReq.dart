class AddChildReq {
  String? childName;
  String? dob;
  String? gender;
  String? profile;

  AddChildReq({this.childName, this.dob, this.gender, this.profile});

  AddChildReq.fromJson(Map<String, dynamic> json) {
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    return data;
  }
}
