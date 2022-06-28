class editChildLanguage {
  int? childId;
  List<String>? language;

  editChildLanguage({this.childId, this.language});

  editChildLanguage.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    language = json['language'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['language'] = this.language;
    return data;
  }
}
