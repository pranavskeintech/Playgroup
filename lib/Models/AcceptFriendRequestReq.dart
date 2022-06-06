class AcceptFriendReq {
  int? childId;
  int? childFriendId;
  int? friendsId;

  AcceptFriendReq({this.childId, this.childFriendId, this.friendsId});

  AcceptFriendReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    friendsId = json['friends_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['friends_id'] = this.friendsId;
    return data;
  }
}
