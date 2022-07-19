class uploadGroupChatAudio {
  String? type;
  int? childId;
  int? groupId;
  String? files;

  uploadGroupChatAudio({this.type, this.childId, this.groupId, this.files});

  uploadGroupChatAudio.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    childId = json['child_id'];
    groupId = json['group_id'];
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['child_id'] = this.childId;
    data['group_id'] = this.groupId;
    data['files'] = this.files;
    return data;
  }
}
