class GetSportsRes {
  bool? status;
  String? message;
  List<Data>? data;

  GetSportsRes({this.status, this.message, this.data});

  GetSportsRes.fromJson(Map<String, dynamic> json) {
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
  int? sportsId;
  String? sportsName;
  String? createdDate;

  Data({this.sportsId, this.sportsName, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    sportsId = json['sports_id'];
    sportsName = json['sports_name'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sports_id'] = this.sportsId;
    data['sports_name'] = this.sportsName;
    data['created_date'] = this.createdDate;
    return data;
  }
}
