class GetProfileRes {
  bool? status;
  String? message;
  Profile? profile;

  GetProfileRes({this.status, this.message, this.profile});

  GetProfileRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? userId;
  String? parentName;
  String? emailId;
  String? phone;
  String? location;
  List<Children>? children;
  List<CoParent>? coParent;

  Profile(
      {this.userId,
      this.parentName,
      this.emailId,
      this.phone,
      this.location,
      this.children,
      this.coParent});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    parentName = json['parent_name'];
    emailId = json['email_id'];
    phone = json['phone'];
    location = json['location'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    if (json['co_parent'] != null) {
      coParent = <CoParent>[];
      json['co_parent'].forEach((v) {
        coParent!.add(new CoParent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['parent_name'] = this.parentName;
    data['email_id'] = this.emailId;
    data['phone'] = this.phone;
    data['location'] = this.location;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.coParent != null) {
      data['co_parent'] = this.coParent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? childId;
  int? parentId;
  Null? coParentId;
  String? childName;
  String? dob;
  String? gender;
  String? profile;
  String? createdDate;

  Children(
      {this.childId,
      this.parentId,
      this.coParentId,
      this.childName,
      this.dob,
      this.gender,
      this.profile,
      this.createdDate});

  Children.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    parentId = json['parent_id'];
    coParentId = json['co_parent_id'];
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
    data['co_parent_id'] = this.coParentId;
    data['child_name'] = this.childName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class CoParent {
  int? userId;
  String? parentName;
  String? emailId;
  String? password;
  String? role;
  String? access;
  String? phone;
  String? location;
  Null? selectedChildId;
  Null? parentId;
  String? createdDate;

  CoParent(
      {this.userId,
      this.parentName,
      this.emailId,
      this.password,
      this.role,
      this.access,
      this.phone,
      this.location,
      this.selectedChildId,
      this.parentId,
      this.createdDate});

  CoParent.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    parentName = json['parent_name'];
    emailId = json['email_id'];
    password = json['password'];
    role = json['role'];
    access = json['access'];
    phone = json['phone'];
    location = json['location'];
    selectedChildId = json['selected_child_id'];
    parentId = json['parent_id'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['parent_name'] = this.parentName;
    data['email_id'] = this.emailId;
    data['password'] = this.password;
    data['role'] = this.role;
    data['access'] = this.access;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['selected_child_id'] = this.selectedChildId;
    data['parent_id'] = this.parentId;
    data['created_date'] = this.createdDate;
    return data;
  }
}
