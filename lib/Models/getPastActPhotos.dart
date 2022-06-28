class getPastActPhotos {
  bool? status;
  String? message;
  List<imgData>? data;

  getPastActPhotos({this.status, this.message, this.data});

  getPastActPhotos.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <imgData>[];
      json['data'].forEach((v) {
        data!.add(new imgData.fromJson(v));
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

class imgData {
  int? pastActivitiesImagesId;
  int? childId;
  int? markavailId;
  String? imageName;
  String? createdDate;
  String? childName;
  String? profile;

  imgData(
      {this.pastActivitiesImagesId,
      this.childId,
      this.markavailId,
      this.imageName,
      this.createdDate,
      this.childName,
      this.profile});

  imgData.fromJson(Map<String, dynamic> json) {
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
