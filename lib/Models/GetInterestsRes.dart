class GetInterestsRes {
  bool? status;
  String? message;
  List<Data>? data;

  GetInterestsRes({this.status, this.message, this.data});

  GetInterestsRes.fromJson(Map<String, dynamic> json) {
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
  int? interestsId;
  String? interestName;
  int? fromAge;
  int? toAge;
  String? country;
  String? createdDate;

  Data(
      {this.interestsId,
      this.interestName,
      this.fromAge,
      this.toAge,
      this.country,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    interestsId = json['interests_id'];
    interestName = json['interest_name'];
    fromAge = json['from_age'];
    toAge = json['to_age'];
    country = json['country'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interests_id'] = this.interestsId;
    data['interest_name'] = this.interestName;
    data['from_age'] = this.fromAge;
    data['to_age'] = this.toAge;
    data['country'] = this.country;
    data['created_date'] = this.createdDate;
    return data;
  }
}
