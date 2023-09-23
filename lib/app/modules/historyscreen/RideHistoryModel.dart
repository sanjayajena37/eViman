class RideHistoryModel {
  bool? success;
  String? message;
  List<Rides>? rides;

  RideHistoryModel({this.success, this.message, this.rides});

  RideHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['rides'] != null) {
      rides = <Rides>[];
      json['rides'].forEach((v) {
        rides!.add(new Rides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.rides != null) {
      data['rides'] = this.rides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rides {
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
  int? otp;
  String? pickupDistance;
  String? createdAt;
  String? updatedAt;

  Rides(
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
        this.pickupDistance,
        this.createdAt,
        this.updatedAt});

  Rides.fromJson(Map<String, dynamic> json) {
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
    pickupAddress = json['pickup_address'].toString();
    dropAddress = json['drop_address'];
    eta = json['eta'];
    distance = json['distance'];
    otp = json['otp'];
    pickupDistance = (json['pickup_distance']??'0').toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['pickup_distance'] = this.pickupDistance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
