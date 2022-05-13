class GetCity {
  bool? status;
  List<Message>? message;

  GetCity({this.status, this.message});

  GetCity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? name;
  String? countryCode;
  String? stateCode;

  Message({this.name, this.countryCode, this.stateCode});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['countryCode'];
    stateCode = json['stateCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['stateCode'] = this.stateCode;
    return data;
  }
}
