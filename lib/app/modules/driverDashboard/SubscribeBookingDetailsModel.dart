class SubscribeBookingDetailsModel {
  SubscribeBookingDetails? subscribeBookingDetails;

  SubscribeBookingDetailsModel({this.subscribeBookingDetails});

  SubscribeBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    subscribeBookingDetails = json['subscribeBookingDetails'] != null
        ? new SubscribeBookingDetails.fromJson(json['subscribeBookingDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscribeBookingDetails != null) {
      data['subscribeBookingDetails'] = this.subscribeBookingDetails!.toJson();
    }
    return data;
  }
}

class SubscribeBookingDetails {
  String? bookingId;
  String? bookingStatus;
  int? otp;
  int? riderId;
  String? updatedBy;
  int? updatedById;
  String? updatedByUserType;
  int? vehicleId;

  SubscribeBookingDetails(
      {this.bookingId,
        this.bookingStatus,
        this.otp,
        this.riderId,
        this.updatedBy,
        this.updatedById,
        this.updatedByUserType,
        this.vehicleId});

  SubscribeBookingDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    bookingStatus = json['bookingStatus'];
    otp = json['otp'];
    riderId = json['riderId'];
    updatedBy = json['updatedBy'];
    updatedById = json['updatedById'];
    updatedByUserType = json['updatedByUserType'];
    vehicleId = json['vehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['bookingStatus'] = this.bookingStatus;
    data['otp'] = this.otp;
    data['riderId'] = this.riderId;
    data['updatedBy'] = this.updatedBy;
    data['updatedById'] = this.updatedById;
    data['updatedByUserType'] = this.updatedByUserType;
    data['vehicleId'] = this.vehicleId;
    return data;
  }
}
