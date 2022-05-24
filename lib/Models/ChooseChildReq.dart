class ChooseChildReq {
  int? selectedChildId;

  ChooseChildReq({this.selectedChildId});

  ChooseChildReq.fromJson(Map<String, dynamic> json) {
    selectedChildId = json['selected_child_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected_child_id'] = this.selectedChildId;
    return data;
  }
}
