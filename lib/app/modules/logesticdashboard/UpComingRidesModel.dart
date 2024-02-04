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
  String? bookingId;
  String? totalAmount;
  String? amountPaid;
  bool? isPaid;
  String? rideStatus;
  String? pickupAddress;
  String? dropAddress;
  String? fromDate;
  String? toDate;

  Rides(
      {this.bookingId,
        this.totalAmount,
        this.amountPaid,
        this.isPaid,
        this.rideStatus,
        this.pickupAddress,
        this.dropAddress,
        this.fromDate,
        this.toDate});

  Rides.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    totalAmount = (json['total_amount']??"0").toString();
    amountPaid = (json['amount_paid']??"").toString();
    isPaid = json['is_paid'];
    rideStatus = json['ride_status'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['is_paid'] = this.isPaid;
    data['ride_status'] = this.rideStatus;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}
