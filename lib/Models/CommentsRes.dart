class CommentRes {
  int? commetId;
  int? childId;
  int? markavailId;
  String? comment;
  String? createdAt;
  int? parentId;
  String? childName;
  String? dob;
  int? age;
  String? gender;
  String? profile;
  String? school;
  String? languages;
  String? createdDate;

  CommentRes(
      {this.commetId,
      this.childId,
      this.markavailId,
      this.comment,
      this.createdAt,
      this.parentId,
      this.childName,
      this.dob,
      this.age,
      this.gender,
      this.profile,
      this.school,
      this.languages,
      this.createdDate});

  CommentRes.fromJson(Map<String, dynamic> json) {
    commetId = json['comment_id'];
    childId = json['child_id'];
    markavailId = json['markavail_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    parentId = json['parent_id'];
    childName = json['child_name'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    profile = json['profile'];
    school = json['school'];
    languages = json['languages'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commetId;
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['parent_id'] = this.parentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['school'] = this.school;
    data['languages'] = this.languages;
    data['created_date'] = this.createdDate;
    return data;
  }
}
