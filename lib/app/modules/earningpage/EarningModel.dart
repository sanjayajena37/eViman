class EarningModel {
  bool? success;
  String? message;
  List<RideArray>? rideArray;

  EarningModel({this.success, this.message, this.rideArray});

  EarningModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['rideArray'] != null) {
      rideArray = <RideArray>[];
      json['rideArray'].forEach((v) {
        rideArray!.add(new RideArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.rideArray != null) {
      data['rideArray'] = this.rideArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RideArray {
  String? distance;
  double? totalAmount;
  String? rideDate;
  String? eta;
  String? rideStartTime;
  String? rideEndTime;
  String? amount_paid;

  RideArray(
      {this.distance,
        this.totalAmount,
        this.rideDate,
        this.eta,
        this.rideStartTime,
        this.rideEndTime,this.amount_paid});

  RideArray.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    totalAmount = json['total_amount'];
    rideDate = json['ride_date'];
    eta = json['eta'];
    rideStartTime = json['ride_start_time'];
    rideEndTime = json['ride_end_time'];
    amount_paid = (json['amount_paid']??"").toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['total_amount'] = this.totalAmount;
    data['ride_date'] = this.rideDate;
    data['eta'] = this.eta;
    data['ride_start_time'] = this.rideStartTime;
    data['ride_end_time'] = this.rideEndTime;
    data['amount_paid'] = this.amount_paid;
    return data;
  }
}
