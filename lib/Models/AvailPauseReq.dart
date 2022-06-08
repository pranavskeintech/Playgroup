class AvailPauseReq {
  int? markavailId;
  String? status;

  AvailPauseReq({this.markavailId, this.status});

  AvailPauseReq.fromJson(Map<String, dynamic> json) {
    markavailId = json['markavail_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markavail_id'] = this.markavailId;
    data['status'] = this.status;
    return data;
  }
}
