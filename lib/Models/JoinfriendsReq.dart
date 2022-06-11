class JoinfriendsReq {
  int? childId;
  int? markavailId;
  String? status;

  JoinfriendsReq({this.childId, this.markavailId});

  JoinfriendsReq.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    markavailId = json['markavail_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    data['status'] = this.status;
    return data;
  }
}
