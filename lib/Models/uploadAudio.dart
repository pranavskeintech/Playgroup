class uploadIndChatAudio {
  String? type;
  int? childId;
  int? otherChildId;
  String? files;

  uploadIndChatAudio({this.type, this.childId, this.otherChildId, this.files});

  uploadIndChatAudio.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    childId = json['child_id'];
    otherChildId = json['other_child_id'];
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['child_id'] = this.childId;
    data['other_child_id'] = this.otherChildId;
    data['files'] = this.files;
    return data;
  }
}
