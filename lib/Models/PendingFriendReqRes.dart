class PendingFriendReqRes {
  bool? status;
  String? message;
  List<FriendReqData>? data;

  PendingFriendReqRes({this.status, this.message, this.data});

  PendingFriendReqRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FriendReqData>[];
      json['data'].forEach((v) {
        data!.add(new FriendReqData.fromJson(v));
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

class FriendReqData {
  int? friendsId;
  int? childId;
  int? childFriendId;
  String? requestStatus;
  String? createdDate;
  String? childName;
  String? profile;

  FriendReqData(
      {this.friendsId,
      this.childId,
      this.childFriendId,
      this.requestStatus,
      this.createdDate,
      this.childName,
      this.profile});

  FriendReqData.fromJson(Map<String, dynamic> json) {
    friendsId = json['friends_id'];
    childId = json['child_id'];
    childFriendId = json['child_friend_id'];
    requestStatus = json['request_status'];
    createdDate = json['created_date'];
    childName = json['child_name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friends_id'] = this.friendsId;
    data['child_id'] = this.childId;
    data['child_friend_id'] = this.childFriendId;
    data['request_status'] = this.requestStatus;
    data['created_date'] = this.createdDate;
    data['child_name'] = this.childName;
    data['profile'] = this.profile;
    return data;
  }
}
