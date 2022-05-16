class GetChildRes {
  bool? status;
  List<ChildData>? data;

  GetChildRes({this.status, this.data});

  GetChildRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ChildData>[];
      json['data'].forEach((v) {
        data!.add(new ChildData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildData {
  int? childId;
  int? parentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? createdDate;

  ChildData(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.createdDate});

  ChildData.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    createdDate = json['created_date'];
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
    return data;
  }
}
