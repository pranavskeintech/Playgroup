class CreateGroupRes {
  bool? status;
  String? message;
  GroupDetails? groupDetails;

  CreateGroupRes({this.status, this.message, this.groupDetails});

  CreateGroupRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    groupDetails = json['groupDetails'] != null
        ? new GroupDetails.fromJson(json['groupDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.groupDetails != null) {
      data['groupDetails'] = this.groupDetails!.toJson();
    }
    return data;
  }
}

class GroupDetails {
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  String? info;
  int? serverStatus;
  int? warningStatus;

  GroupDetails(
      {this.fieldCount,
      this.affectedRows,
      this.insertId,
      this.info,
      this.serverStatus,
      this.warningStatus});

  GroupDetails.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    info = json['info'];
    serverStatus = json['serverStatus'];
    warningStatus = json['warningStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldCount'] = this.fieldCount;
    data['affectedRows'] = this.affectedRows;
    data['insertId'] = this.insertId;
    data['info'] = this.info;
    data['serverStatus'] = this.serverStatus;
    data['warningStatus'] = this.warningStatus;
    return data;
  }
}
