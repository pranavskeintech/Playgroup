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
  int? friendsId;
  int? childId;
  int? parentId;
  String? parentName;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? school;
  String? location;
  String? createdDate;
  String? status;
  List<String>? languages;
  List<Interests>? interests;
  List<Frndsdata>? frndsdata;

  childData(
      {this.friendsId,
      this.childId,
      this.parentId,
      this.parentName,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.school,
      this.location,
      this.createdDate,
      this.status,
      this.languages,
      this.interests,
      this.frndsdata});

  childData.fromJson(Map<String, dynamic> json) {
    friendsId = json['friends_id'];
    childId = json['child_id'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
    childName = json['child_name'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    location = json['location'];
    createdDate = json['created_date'];
    status = json['status'];
    languages = json['languages'].cast<String>();
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
    if (json['frndsdata'] != null) {
      frndsdata = <Frndsdata>[];
      json['frndsdata'].forEach((v) {
        frndsdata!.add(new Frndsdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friends_id'] = this.friendsId;
    data['child_id'] = this.childId;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    data['location'] = this.location;
    data['created_date'] = this.createdDate;
    data['status'] = this.status;
    data['languages'] = this.languages;
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    if (this.frndsdata != null) {
      data['frndsdata'] = this.frndsdata!.map((v) => v.toJson()).toList();
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

class Frndsdata {
  int? friendsId;
  int? childId;
  int? childFriendId;
  String? requestStatus;
  String? createdDate;
  String? childName;
  String? profile;

  Frndsdata(
      {this.friendsId,
      this.childId,
      this.childFriendId,
      this.requestStatus,
      this.createdDate,
      this.childName,
      this.profile});

  Frndsdata.fromJson(Map<String, dynamic> json) {
    friendsId = json['friends_id'];
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    requestStatus = json['request_status'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friends_id'] = this.friendsId;
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['request_status'] = this.requestStatus;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
