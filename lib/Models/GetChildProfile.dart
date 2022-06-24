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
  int? age;
  String? gender;
  String? profile;
  String? school;
  String? createdDate;
  String? location;
  List<String>? languages;
  List<Interests>? interests;

  Data(
      {this.childId,
      this.parentId,
      this.childName,
      this.dob,
      this.age,
      this.gender,
      this.profile,
      this.school,
      this.createdDate,
      this.location,
      this.languages,
      this.interests});

  Data.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    createdDate = json['created_date'];
    location = json['location'];
    languages = json['languages'].cast<String>();
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
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
    data['created_date'] = this.createdDate;
    data['location'] = this.location;
    data['languages'] = this.languages;
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interests {
  int? childInterestsId;
  int? childId;
  int? interestsId;
  String? createdDate;
  String? interestName;
  String? interestImage;

  Interests(
      {this.childInterestsId,
      this.childId,
      this.interestsId,
      this.createdDate,
      this.interestName,
      this.interestImage});

  Interests.fromJson(Map<String, dynamic> json) {
    childInterestsId = json['child_interests_id'];
    childId = json['child_id'];
    interestsId = json['interests_id'];
    createdDate = json['created_date'];
    interestName = json['interest_name'];
    interestImage = json['interest_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_interests_id'] = this.childInterestsId;
    data['child_id'] = this.childId;
    data['interests_id'] = this.interestsId;
    data['created_date'] = this.createdDate;
    data['interest_name'] = this.interestName;
    data['interest_image'] = this.interestImage;
    return data;
  }
}
