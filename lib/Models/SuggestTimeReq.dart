class SuggestTimeReq {
  String? from;
  String? to;
  int? otherChildId;
  int? childId;

  SuggestTimeReq({this.from, this.to, this.otherChildId, this.childId});

  SuggestTimeReq.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    otherChildId = json['other_child_id'];
    childId = json['child_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['other_child_id'] = this.otherChildId;
    data['child_id'] = this.childId;
    return data;
  }
}
