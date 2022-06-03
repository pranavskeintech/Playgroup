class FriendRequestReq {
  int? childId;
  int? childFriendId;

  FriendRequestReq({this.childId, this.childFriendId});

  FriendRequestReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    return data;
  }
}
