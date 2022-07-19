class uploadAvailChatAudio {
  String? type;
  int? childId;
  int? markavailId;
  String? files;

  uploadAvailChatAudio({this.type, this.childId, this.markavailId, this.files});

  uploadAvailChatAudio.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    childId = json['child_id'];
    markavailId = json['markavail_id'];
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    data['files'] = this.files;
    return data;
  }
}
