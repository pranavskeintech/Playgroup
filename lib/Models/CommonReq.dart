class CommonReq {
 
  int? childId;
  int? markavailId;
  

  CommonReq({
    
    this.childId,
    this.markavailId,
   
  });

  CommonReq.fromJson(Map<String, dynamic> json) {
   

    childId = json['child_id'];
    markavailId = json['markavail_id'];
    

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   

    data['child_id'] = childId;
    data['markavail_id'] = markavailId;
   

    return data;
  }
}



