class SearchresultRes {
  bool? status;
  String? message;
  List<SearchData>? data;

  SearchresultRes({this.status, this.message, this.data});

  SearchresultRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(new SearchData.fromJson(v));
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

class SearchData {
  int? childId;
  int? parentId;
  String? childName;
  String? dob;
  int? age;
  String? gender;
  String? profile;
  String? school;
  String? languages;
  String? createdDate;
  String? parentName;
  String? location;

  SearchData(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.age,
      this.gender,
      this.profile,
      this.school,
      this.languages,
      this.createdDate,
      this.parentName,
      this.location});

  SearchData.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    languages = json['languages'];
    createdDate = json['created_date'];
    parentName = json['parent_name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    data['languages'] = this.languages;
    data['created_date'] = this.createdDate;
    data['parent_name'] = this.parentName;
    data['location'] = this.location;
    return data;
  }
}
