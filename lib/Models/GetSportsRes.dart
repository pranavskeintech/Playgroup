class GetSportsRes {
  bool? status;
  String? message;
  List<SportsData>? data;

  GetSportsRes({this.status, this.message, this.data});

  GetSportsRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SportsData>[];
      json['data'].forEach((v) {
        data!.add(new SportsData.fromJson(v));
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

class SportsData {
  int? sportsId;
  int? activitiesId;
  String? sportsName;
  String? benefits;
  String? createdDate;

  SportsData(
      {this.sportsId,
      this.activitiesId,
      this.sportsName,
      this.benefits,
      this.createdDate});

  SportsData.fromJson(Map<String, dynamic> json) {
    sportsId = json['sports_id'];
    activitiesId = json['activities_id'];
    sportsName = json['sports_name'];
    benefits = json['benefits'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sports_id'] = this.sportsId;
    data['activities_id'] = this.activitiesId;
    data['sports_name'] = this.sportsName;
    data['benefits'] = this.benefits;
    data['created_date'] = this.createdDate;
    return data;
  }
}
