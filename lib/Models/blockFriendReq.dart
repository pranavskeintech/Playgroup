class blockFriend {
  int? childId;
  int? childBlockId;
  String? blkstatus;

  blockFriend({this.childId, this.childBlockId, this.blkstatus});

  blockFriend.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childBlockId = json['child_block_id'];
    blkstatus = json['blkstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_block_id'] = this.childBlockId;
    data['blkstatus'] = this.blkstatus;
    return data;
  }
}
