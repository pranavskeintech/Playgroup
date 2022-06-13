class GetChildProfileRes {
  bool? status;
  String? message;
  List<Data>? data;

  GetChildProfileRes({this.status, this.message, this.data});

  GetChildProfileRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? childId;
  int? parentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? school;
  String? createdDate;
  String? location;

  Data(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.school,
      this.createdDate,
      this.location});

  Data.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    createdDate = json['created_date'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    data['created_date'] = this.createdDate;
    data['location'] = this.location;
    return data;
  }
}
