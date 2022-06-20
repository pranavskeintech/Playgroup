class RemoveParticipantsGroupReq {
  List<int>? groupParticipants;

  RemoveParticipantsGroupReq({this.groupParticipants});

  RemoveParticipantsGroupReq.fromJson(Map<String, dynamic> json) {
    groupParticipants = json['groupParticipants'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupParticipants'] = this.groupParticipants;
    return data;
  }
}
