class UpComingRidesModel {
  bool? success;
  String? message;
  List<Rides>? rides;

  UpComingRidesModel({this.success, this.message, this.rides});

  UpComingRidesModel.fromJson(Map<String, dynamic> json) {
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
  String? amountPaid;
  int? isPaid;
  String? rideDate;
  String? pickupLat;
  String? pickupLng;
  String? dropLat;
  String? dropLng;
  String? rideStartTime;
  String? rideEndTime;
  String? rideStatus;
  String? pickupAddress;
  String? dropAddress;
  String? eta;
  String? distance;
  int? otp;
  String? pickupDistance;
  String? rideType;
  String? createdAt;
  String? updatedAt;
  String? riderHead;
  String? adminCommission;
  String? adminCommissionPercentage;
  String? riderCommission;
  String? cancellationTime;
  String? cancellationCharges;
  String? isRefunded;
  String? refundTxnId;
  String? promocodeId;
  String? promocodeDiscount;
  String? actualAmount;
  String? ride;
  String? fromDate;
  String? toDate;
  List<int>? riders;

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
        this.rideDate,
        this.pickupLat,
        this.pickupLng,
        this.dropLat,
        this.dropLng,
        this.rideStartTime,
        this.rideEndTime,
        this.rideStatus,
        this.pickupAddress,
        this.dropAddress,
        this.eta,
        this.distance,
        this.otp,
        this.pickupDistance,
        this.rideType,
        this.createdAt,
        this.updatedAt,
        this.riderHead,
        this.adminCommission,
        this.adminCommissionPercentage,
        this.riderCommission,
        this.cancellationTime,
        this.cancellationCharges,
        this.isRefunded,
        this.refundTxnId,
        this.promocodeId,
        this.promocodeDiscount,
        this.actualAmount,
        this.ride,
        this.fromDate,
        this.toDate,
        this.riders});

  Rides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    clientId = json['client_id'];
    vehicleAssigned = json['vehicle_assigned'];
    riderAssigned = json['rider_assigned'];
    fareInfo = json['fare_info'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    amountPaid =( json['amount_paid']??"0").toString();
    isPaid = json['is_paid'];
    rideDate = json['ride_date'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropLat = json['drop_lat'];
    dropLng = json['drop_lng'];
    rideStartTime = json['ride_start_time'];
    rideEndTime = (json['ride_end_time']??"").toString();
    rideStatus = json['ride_status'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    eta = json['eta'];
    distance = json['distance'];
    otp = json['otp'];
    pickupDistance = (json['pickup_distance']??"").toString();
    rideType = json['ride_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    riderHead = (json['riderHead']??"").toString();
    adminCommission = (json['admin_commission']??"").toString();
    adminCommissionPercentage = (json['admin_commission_percentage']??"0").toString();
    riderCommission = (json['rider_commission']??"0").toString();
    cancellationTime = (json['cancellation_time']??"").toString();
    cancellationCharges = (json['cancellation_charges']??"").toString();
    isRefunded = (json['is_refunded']??"0").toString();
    refundTxnId = (json['refund_txn_id']??"").toString();
    promocodeId = (json['promocode_id']??"").toString();
    promocodeDiscount = (json['promocode_discount']??"").toString();
    actualAmount = (json['actual_amount']??"").toString();
    ride = json['ride'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    riders = json['riders'].cast<int>();
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
    data['ride_date'] = this.rideDate;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['drop_lat'] = this.dropLat;
    data['drop_lng'] = this.dropLng;
    data['ride_start_time'] = this.rideStartTime;
    data['ride_end_time'] = this.rideEndTime;
    data['ride_status'] = this.rideStatus;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['eta'] = this.eta;
    data['distance'] = this.distance;
    data['otp'] = this.otp;
    data['pickup_distance'] = this.pickupDistance;
    data['ride_type'] = this.rideType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['riderHead'] = this.riderHead;
    data['admin_commission'] = this.adminCommission;
    data['admin_commission_percentage'] = this.adminCommissionPercentage;
    data['rider_commission'] = this.riderCommission;
    data['cancellation_time'] = this.cancellationTime;
    data['cancellation_charges'] = this.cancellationCharges;
    data['is_refunded'] = this.isRefunded;
    data['refund_txn_id'] = this.refundTxnId;
    data['promocode_id'] = this.promocodeId;
    data['promocode_discount'] = this.promocodeDiscount;
    data['actual_amount'] = this.actualAmount;
    data['ride'] = this.ride;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['riders'] = this.riders;
    return data;
  }
}
