class reportUser {
  int? childId;
  int? childFriendId;
  String? reportmsg;

  reportUser({this.childId, this.childFriendId, this.reportmsg});

  reportUser.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    reportmsg = json['reportmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['reportmsg'] = this.reportmsg;
    return data;
  }
}
