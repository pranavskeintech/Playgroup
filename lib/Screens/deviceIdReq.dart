class deviceIdReq 
{
  int? parentId;
  String? deviceId;

  deviceIdReq({this.parentId, this.deviceId});

  deviceIdReq.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['device_id'] = this.deviceId;
    return data;
  }
}
