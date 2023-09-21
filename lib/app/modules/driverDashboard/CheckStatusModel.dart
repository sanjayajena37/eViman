class CheckStatusModel {
  bool? success;
  String? message;
  RiderStatus? riderStatus;

  CheckStatusModel({this.success, this.message, this.riderStatus});

  CheckStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    riderStatus = json['riderStatus'] != null
        ? new RiderStatus.fromJson(json['riderStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.riderStatus != null) {
      data['riderStatus'] = this.riderStatus!.toJson();
    }
    return data;
  }
}

class RiderStatus {
  bool? isOnline;
  int? riderId;
  int? vehicleId;
  String ? clientPhone;
  String ? clientName;
  ActiveRide? activeRide;

  RiderStatus({this.isOnline, this.riderId, this.vehicleId, this.activeRide});

  RiderStatus.fromJson(Map<String, dynamic> json) {
    isOnline = json['isOnline'];
    riderId = json['riderId'];
    vehicleId = json['vehicleId'];
    clientPhone = json['clientPhone'];
    clientName = json['clientName'];
    activeRide = json['activeRide'] != null
        ? new ActiveRide.fromJson(json['activeRide'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnline'] = this.isOnline;
    data['riderId'] = this.riderId;
    data['clientPhone'] = this.clientPhone;
    data['clientName'] = this.clientName;
    data['vehicleId'] = this.vehicleId;
    if (this.activeRide != null) {
      data['activeRide'] = this.activeRide!.toJson();
    }
    return data;
  }
}

class ActiveRide {
  int? id;
  String? bookingId;
  int? clientId;
  String? vehicleAssigned;
  String? riderAssigned;
  int? fareInfo;
  int? discount;
  double? totalAmount;
  int? amountPaid;
  bool? isPaid;
  String? rideStatus;
  String? rideDate;
  String? pickupLat;
  String? pickupLng;
  String? dropLat;
  String? dropLng;
  String? rideStartTime;
  String? rideEndTime;
  String? pickupAddress;
  String? dropAddress;
  String? eta;
  String? distance;
  String? clientName;
  String? pickupDistance;
  int? otp;
  String? createdAt;
  String? updatedAt;

  ActiveRide(
      {this.id,
        this.bookingId,
        this.clientId,
        this.vehicleAssigned,
        this.riderAssigned,
        this.fareInfo,
        this.discount,
        this.totalAmount,
        this.amountPaid,
        this.isPaid,
        this.rideStatus,
        this.rideDate,
        this.pickupLat,
        this.pickupLng,
        this.dropLat,
        this.dropLng,
        this.rideStartTime,
        this.rideEndTime,
        this.pickupAddress,
        this.dropAddress,
        this.eta,
        this.distance,
        this.otp,
        this.createdAt,
        this.updatedAt,this.clientName,this.pickupDistance});

  ActiveRide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    clientId = json['client_id'];
    vehicleAssigned = json['vehicle_assigned'];
    riderAssigned = json['rider_assigned'];
    fareInfo = json['fare_info'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    amountPaid = json['amount_paid'];
    isPaid = json['is_paid'];
    rideStatus = json['ride_status'];
    rideDate = json['ride_date'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropLat = json['drop_lat'];
    dropLng = json['drop_lng'];
    rideStartTime = json['ride_start_time'];
    rideEndTime = json['ride_end_time'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    eta = json['eta'];
    distance = json['distance'];
    otp = json['otp'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    clientName = json['clientName'];
    pickupDistance = json['pickupDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['client_id'] = this.clientId;
    data['vehicle_assigned'] = this.vehicleAssigned;
    data['rider_assigned'] = this.riderAssigned;
    data['fare_info'] = this.fareInfo;
    data['discount'] = this.discount;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['is_paid'] = this.isPaid;
    data['ride_status'] = this.rideStatus;
    data['ride_date'] = this.rideDate;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['drop_lat'] = this.dropLat;
    data['drop_lng'] = this.dropLng;
    data['ride_start_time'] = this.rideStartTime;
    data['ride_end_time'] = this.rideEndTime;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['eta'] = this.eta;
    data['distance'] = this.distance;
    data['otp'] = this.otp;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['pickupDistance'] = this.pickupDistance;
    data['clientName'] = this.clientName;
    return data;
  }
}
