class CommonReq {
  String? emailOrPhoneNo;
  String? password;
  String? emailId;
  int? otp;
  String? orderReturnStatus;
  String? status;
  String? deliveredDate;
  int? userId;
  int? orderId;
  bool? isReorder;
  String? reasonForReturning;
  int? orderAddressId;
  String? returnType;
  String? paymentType;
  int? paymentStatus;
  List<ReturnProductsData>? returnProductsData;

  int? returnOrderId;
  String? returnRemarks;
  int? isProductReturned;

  CommonReq({
    this.deliveredDate,
    this.paymentStatus,
    this.emailOrPhoneNo,
    this.password,
    this.emailId,
    this.orderReturnStatus,
    this.status,
    this.userId,
    this.orderId,
    this.isReorder,
    this.reasonForReturning,
    this.orderAddressId,
    this.returnType,
    this.paymentType,
    this.returnProductsData,
    this.returnOrderId,
    this.returnRemarks,
    this.isProductReturned,
  });

  CommonReq.fromJson(Map<String, dynamic> json) {
    deliveredDate = json['delivered_date'];
    paymentStatus = json['payment_status'];
    emailOrPhoneNo = json['email_or_phone_no'];
    password = json['password'];
    emailId = json['email_id'];
    otp = json['otp'];
    orderReturnStatus = json['order_return_status'];
    status = json['status'];

    userId = json['user_id'];
    orderId = json['order_id'];
    isReorder = json['is_reorder'];
    reasonForReturning = json['reason_for_returning'];
    orderAddressId = json['order_address_id'];
    returnType = json['return_type'];
    paymentType = json['payment_type'];

    returnOrderId = json['return_order_id'];
    returnRemarks = json['return_remarks'];
    isProductReturned = json['is_product_returned'];

    if (json['return_products_data'] != null) {
      returnProductsData = <ReturnProductsData>[];
      json['return_products_data'].forEach((v) {
        returnProductsData?.add(ReturnProductsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivered_date'] = deliveredDate;
    data['payment_status'] = paymentStatus;
    data['email_or_phone_no'] = emailOrPhoneNo;
    data['password'] = password;
    data['email_id'] = emailId;
    data['otp'] = otp;
    data['order_return_status'] = orderReturnStatus;
    data['status'] = status;

    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['is_reorder'] = isReorder;
    data['reason_for_returning'] = reasonForReturning;
    data['order_address_id'] = orderAddressId;
    data['return_type'] = returnType;
    data['payment_type'] = paymentType;

    data['return_order_id'] = returnOrderId;
    data['return_remarks'] = returnRemarks;
    data['is_product_returned'] = isProductReturned;

    if (returnProductsData != null) {
      data['return_products_data'] =
          returnProductsData?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ReturnProductsData {
  int? orderId;
  int? productId;
  int? isProductReturned;

  ReturnProductsData({this.orderId, this.productId, this.isProductReturned});

  ReturnProductsData.fromJson(Map<String, dynamic> json) 
  {
    orderId = json['order_id'];
    productId = json['product_id'];
    isProductReturned = json['is_product_returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['is_product_returned'] = isProductReturned;
    return data;
  }
}
