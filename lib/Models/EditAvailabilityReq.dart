class EditAvailabilityReq {
  int? markId;
  int? childId;
  String? date;
  String? from;
  String? to;
  String? description;
  String? location;
  int? activitiesId;
  int? sportId;
  List<int>? friendId;

  EditAvailabilityReq(
      {this.markId,
      this.childId,
      this.date,
      this.from,
      this.to,
      this.description,
      this.location,
      this.activitiesId,
      this.sportId,
      this.friendId});

  EditAvailabilityReq.fromJson(Map<String, dynamic> json) {
    markId = json['mark_id'];
    childId = json['child_id'];
    date = json['date'];
    from = json['from'];
    to = json['to'];
    description = json['description'];
    location = json['location'];
    activitiesId = json['activities_id'];
    sportId = json['sport_id'];
    friendId = json['friend_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mark_id'] = this.markId;
    data['child_id'] = this.childId;
    data['date'] = this.date;
    data['from'] = this.from;
    data['to'] = this.to;
    data['description'] = this.description;
    data['location'] = this.location;
    data['activities_id'] = this.activitiesId;
    data['sport_id'] = this.sportId;
    data['friend_id'] = this.friendId;
    return data;
  }
}
