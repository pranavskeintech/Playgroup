class GetAllActivities {
  bool? status;
  String? message;
  List<ActData>? data;

  GetAllActivities({this.status, this.message, this.data});

  GetAllActivities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ActData>[];
      json['data'].forEach((v) {
        data!.add(new ActData.fromJson(v));
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

class ActData {
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
  String? activitiesName;
  String? activitiesImg;
  String? type;

  ActData(
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
      this.activitiesName,
      this.activitiesImg,
      this.type});

  ActData.fromJson(Map<String, dynamic> json) {
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
    activitiesName = json['activities_name'];
    activitiesImg = json['activities_img'];
    type = json['type'];
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
    data['activities_name'] = this.activitiesName;
    data['activities_img'] = this.activitiesImg;
    data['type'] = this.type;
    return data;
  }
}
