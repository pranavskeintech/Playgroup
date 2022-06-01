class GetActivitiesRes {
  bool? status;
  String? message;
  List<GetSportsMessage>? data;

  GetActivitiesRes({this.status, this.message, this.data});

  GetActivitiesRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetSportsMessage>[];
      json['data'].forEach((v) {
        data!.add(new GetSportsMessage.fromJson(v));
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

class GetSportsMessage {
  int? activitiesId;
  String? activitiesName;
  String? activitiesImg;
  int? rank;
  String? createdDate;
  String? position;

  GetSportsMessage(
      {this.activitiesId,
      this.activitiesName,
      this.activitiesImg,
      this.rank,
      this.createdDate,
      this.position});

  GetSportsMessage.fromJson(Map<String, dynamic> json) {
    activitiesId = json['activities_id'];
    activitiesName = json['activities_name'];
    activitiesImg = json['activities_img'];
    rank = json['rank'];
    createdDate = json['created_date'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activities_id'] = this.activitiesId;
    data['activities_name'] = this.activitiesName;
    data['activities_img'] = this.activitiesImg;
    data['rank'] = this.rank;
    data['created_date'] = this.createdDate;
    data['position'] = this.position;
    return data;
  }
}
