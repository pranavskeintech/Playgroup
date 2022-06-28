class editChildInt {
  int? childId;
  List<int>? childInterest;

  editChildInt({this.childId, this.childInterest});

  editChildInt.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childInterest = json['child_interest'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_interest'] = this.childInterest;
    return data;
  }
}
