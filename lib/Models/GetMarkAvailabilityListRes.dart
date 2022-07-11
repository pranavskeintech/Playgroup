// class ownAvailabilityListRes {
//   bool? status;
//   String? message;
//   List<AvailabilityListData>? data;

//   ownAvailabilityListRes({this.status, this.message, this.data});

//   ownAvailabilityListRes.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <AvailabilityListData>[];
//       json['data'].forEach((v) {
//         data!.add(new AvailabilityListData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AvailabilityListData {
//   int? markavailId;
//   int? parentId;
//   int? childId;
//   String? dateon;
//   String? fromTime;
//   String? toTime;
//   String? description;
//   String? location;
//   int? activitiesId;
//   int? sportId;
//   String? status;
//   String? createdDate;
//   String? categoryName;
//   String? categoryImg;
//   String? childName;
//   String? activitiesName;
//   String? activitiesImg;

//   AvailabilityListData(
//       {this.markavailId,
//       this.parentId,
//       this.childId,
//       this.dateon,
//       this.fromTime,
//       this.toTime,
//       this.description,
//       this.location,
//       this.activitiesId,
//       this.sportId,
//       this.status,
//       this.createdDate,
//       this.categoryName,
//       this.categoryImg,
//       this.childName,
//       this.activitiesName,
//       this.activitiesImg});

//   AvailabilityListData.fromJson(Map<String, dynamic> json) {
//     markavailId = json['markavail_id'];
//     parentId = json['parent_id'];
//     childId = json['child_id'];
//     dateon = json['dateon'];
//     fromTime = json['from_time'];
//     toTime = json['to_time'];
//     description = json['description'];
//     location = json['location'];
//     activitiesId = json['activities_id'];
//     sportId = json['sport_id'];
//     status = json['status'];
//     createdDate = json['created_date'];
//     categoryName = json['category_name'];
//     categoryImg = json['category_img'];
//     childName = json['child_name'];
//     activitiesName = json['activities_name'];
//     activitiesImg = json['activities_img'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['markavail_id'] = this.markavailId;
//     data['parent_id'] = this.parentId;
//     data['child_id'] = this.childId;
//     data['dateon'] = this.dateon;
//     data['from_time'] = this.fromTime;
//     data['to_time'] = this.toTime;
//     data['description'] = this.description;
//     data['location'] = this.location;
//     data['activities_id'] = this.activitiesId;
//     data['sport_id'] = this.sportId;
//     data['status'] = this.status;
//     data['created_date'] = this.createdDate;
//     data['category_name'] = this.categoryName;
//     data['category_img'] = this.categoryImg;
//     data['child_name'] = this.childName;
//     data['activities_name'] = this.activitiesName;
//     data['activities_img'] = this.activitiesImg;
//     return data;
//   }
// }
