class AvailabilitiesRes 
{
  bool? status;
  String? message;
  List<AvailabilityResData>? data;

  AvailabilitiesRes({this.status, this.message, this.data});

  AvailabilitiesRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AvailabilityResData>[];
      json['data'].forEach((v) {
        data!.add(new AvailabilityResData.fromJson(v));
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

class AvailabilityResData {
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
  String? status;
  String? createdDate;
  String? categoryName;
  String? categoryImg;
  String? childName;
  List<Friendsdata>? friendsdata;

  AvailabilityResData(
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
      this.status,
      this.createdDate,
      this.categoryName,
      this.categoryImg,
      this.childName,
      this.friendsdata});

  AvailabilityResData.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    createdDate = json['created_date'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    childName = json['child_name'];
    if (json['friendsdata'] != null) {
      friendsdata = <Friendsdata>[];
      json['friendsdata'].forEach((v) {
        friendsdata!.add(new Friendsdata.fromJson(v));
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
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['child_name'] = this.childName;
    if (this.friendsdata != null) {
      data['friendsdata'] = this.friendsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friendsdata {
  int? markAvailFriendsId;
  int? markavailId;
  int? childId;
  int? childFriendId;
  String? requestStatus;
  String? createdDate;
  String? friendName;
  String? profile;

  Friendsdata(
      {this.markAvailFriendsId,
      this.markavailId,
      this.childId,
      this.childFriendId,
      this.requestStatus,
      this.createdDate,
      this.friendName,
      this.profile});

  Friendsdata.fromJson(Map<String, dynamic> json) {
    markAvailFriendsId = json['mark_avail_friends_id'];
    markavailId = json['markavail_id'];
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    requestStatus = json['request_status'];
    createdDate = json['created_date'];
    friendName = json['friend_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mark_avail_friends_id'] = this.markAvailFriendsId;
    data['markavail_id'] = this.markavailId;
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['request_status'] = this.requestStatus;
    data['created_date'] = this.createdDate;
    data['friend_name'] = this.friendName;
    data['profile'] = this.profile;
    return data;
  }
}
