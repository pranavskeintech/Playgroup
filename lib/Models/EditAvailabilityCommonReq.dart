class EditAvailabilityCommonReq {
  int? markId;
  int? childId;
  String? from;
  String? to;
  List<int>? friendId;

  EditAvailabilityCommonReq(
      {this.markId, this.childId, this.from, this.to, this.friendId});

  EditAvailabilityCommonReq.fromJson(Map<String, dynamic> json) {
    markId = json['mark_id'];
    childId = json['child_id'];
    from = json['from'];
    to = json['to'];
    friendId = json['friend_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mark_id'] = this.markId;
    data['child_id'] = this.childId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['friend_id'] = this.friendId;
    return data;
  }
}
