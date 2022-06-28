class uploadPastActPhotos {
  int? childId;
  int? markavailId;
  List<String>? image;

  uploadPastActPhotos({this.childId, this.markavailId, this.image});

  uploadPastActPhotos.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    markavailId = json['markavail_id'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['markavail_id'] = this.markavailId;
    data['image'] = this.image;
    return data;
  }
}
