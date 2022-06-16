class addGroupParticipants {
  List<int>? groupMembers;

  addGroupParticipants({this.groupMembers});

  addGroupParticipants.fromJson(Map<String, dynamic> json) {
    groupMembers = json['group_members'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_members'] = this.groupMembers;
    return data;
  }
}
