class GroupsAndFriends {
  bool? status;
  String? message;
  List<Datas>? datas;

  GroupsAndFriends({this.status, this.message, this.datas});

  GroupsAndFriends.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datas'] != null) {
      datas = <Datas>[];
      json['datas'].forEach((v) {
        datas!.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datas != null) {
      data['datas'] = this.datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? name;
  String? image;
  String? type;

  Datas({this.id, this.name, this.image, this.type});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['Type'] = this.type;
    return data;
  }
}
