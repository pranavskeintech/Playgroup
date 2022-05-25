class AddChildReq2 {
  String? childName;
  String? dob;
  String? gender;

  AddChildReq2({this.childName, this.dob, this.gender});

  AddChildReq2.fromJson(Map<String, dynamic> json) {
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}
