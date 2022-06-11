class JoinfriendsReq {
  int? childId;
  int? markavailId;

  JoinfriendsReq({this.childId, this.markavailId});

  JoinfriendsReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    markavailId = json['markavail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    return data;
  }
}
