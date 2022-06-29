class PastActivitiesRes {
  bool? status;
  String? message;
  List<Data>? data;

  PastActivitiesRes({this.status, this.message, this.data});

  PastActivitiesRes.fromJson(Map<String, dynamic> json) {
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
  int? markavailId;
  int? parentId;
  int? childId;
  String? dateon;
  String? fromTime;
  String? toTime;
  String? description;
  String? location;
  int? activitiesId;
  int? sportId;
  String? activityStatus;
  String? status;
  String? createdDate;
  String? categoryName;
  String? categoryImg;
  String? childName;
  String? profile;
  String? activitiesName;
  String? activitiesImg;
  int? markAvailFriendsId;
  int? totalParticipants;
  List<Images>? images;

  Data(
      {this.markavailId,
      this.parentId,
      this.childId,
      this.dateon,
      this.fromTime,
      this.toTime,
      this.description,
      this.location,
      this.activitiesId,
      this.sportId,
      this.activityStatus,
      this.status,
      this.createdDate,
      this.categoryName,
      this.categoryImg,
      this.childName,
      this.profile,
      this.activitiesName,
      this.activitiesImg,
      this.markAvailFriendsId,
      this.totalParticipants,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    markavailId = json['markavail_id'];
    parentId = json['parent_id'];
    childId = json['child_id'];
    dateon = json['dateon'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    description = json['description'];
    location = json['location'];
    activitiesId = json['activities_id'];
    sportId = json['sport_id'];
    activityStatus = json['activity_status'];
    status = json['status'];
    createdDate = json['created_date'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    childName = json['child_name'];
    profile = json['profile'];
    activitiesName = json['activities_name'];
    activitiesImg = json['activities_img'];
    markAvailFriendsId = json['mark_avail_friends_id'];
    totalParticipants = json['total_participants'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markavail_id'] = this.markavailId;
    data['parent_id'] = this.parentId;
    data['child_id'] = this.childId;
    data['dateon'] = this.dateon;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['description'] = this.description;
    data['location'] = this.location;
    data['activities_id'] = this.activitiesId;
    data['sport_id'] = this.sportId;
    data['activity_status'] = this.activityStatus;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    data['activities_name'] = this.activitiesName;
    data['activities_img'] = this.activitiesImg;
    data['mark_avail_friends_id'] = this.markAvailFriendsId;
    data['total_participants'] = this.totalParticipants;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? pastActivitiesImagesId;
  int? childId;
  int? markavailId;
  String? imageName;
  String? createdDate;
  String? childName;
  String? profile;

  Images(
      {this.pastActivitiesImagesId,
      this.childId,
      this.markavailId,
      this.imageName,
      this.createdDate,
      this.childName,
      this.profile});

  Images.fromJson(Map<String, dynamic> json) {
    pastActivitiesImagesId = json['past_activities_images_id'];
    childId = json['child_id'];
    markavailId = json['markavail_id'];
    imageName = json['image_name'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['past_activities_images_id'] = this.pastActivitiesImagesId;
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    data['image_name'] = this.imageName;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
