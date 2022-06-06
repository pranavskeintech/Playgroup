class OtherChildRes {
  bool? status;
  String? message;
  List<childData>? data;

  OtherChildRes({this.status, this.message, this.data});

  OtherChildRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <childData>[];
      json['data'].forEach((v) {
        data!.add(new childData.fromJson(v));
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

class childData {
  int? childId;
  int? parentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? createdDate;
  String? status;

  childData(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.createdDate,
      this.status});

  childData.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    createdDate = json['created_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['created_date'] = this.createdDate;
    data['status'] = this.status;
    return data;
  }
}
