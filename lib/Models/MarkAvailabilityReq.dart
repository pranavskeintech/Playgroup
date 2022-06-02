class MarkAvailabilityReq {
  int? childId;
  String? date;
  String? from;
  String? to;
  String? description;
  String? location;
  int? activitiesId;
  int? sportId;

  MarkAvailabilityReq(
      {this.date,
      this.childId,
      this.from,
      this.to,
      this.description,
      this.location,
      this.activitiesId,
      this.sportId});

  MarkAvailabilityReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    date = json['date'];
    from = json['from'];
    to = json['to'];
    description = json['description'];
    location = json['location'];
    activitiesId = json['activities_id'].cast<String>();
    sportId = json['sport_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['date'] = this.date;
    data['from'] = this.from;
    data['to'] = this.to;
    data['description'] = this.description;
    data['location'] = this.location;
    data['activities_id'] = this.activitiesId;
    data['sport_id'] = this.sportId;
    return data;
  }
}
