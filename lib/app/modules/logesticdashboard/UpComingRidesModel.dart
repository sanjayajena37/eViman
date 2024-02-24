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
  int? clientId;
  String? bookingId;
  String? totalAmount;
  String? amountPaid;
  bool? isPaid;
  String? rideStatus;
  String? pickupAddress;
  String? dropAddress;
  String? fromDate;
  String? toDate;
  bool ?acceptClick;
  bool ?rejectClick;
  ClientDetails? clientDetails;

  Rides(
      {this.clientId,
        this.bookingId,
        this.totalAmount,
        this.amountPaid,
        this.isPaid,
        this.rideStatus,
        this.pickupAddress,
        this.dropAddress,
        this.fromDate,
        this.toDate,
        this.clientDetails,this.acceptClick,this.rejectClick});

  Rides.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    acceptClick = json['acceptClick'];
    rejectClick = json['rejectClick'];
    bookingId = json['booking_id'];
    totalAmount = (json['total_amount']??"0").toString();
    amountPaid = (json['amount_paid']??"0").toString();
    isPaid = json['is_paid'];
    rideStatus = json['ride_status'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['acceptClick'] = this.acceptClick;
    data['rejectClick'] = this.rejectClick;
    data['booking_id'] = this.bookingId;
    data['total_amount'] = this.totalAmount;
    data['amount_paid'] = this.amountPaid;
    data['is_paid'] = this.isPaid;
    data['ride_status'] = this.rideStatus;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    return data;
  }
}

class ClientDetails {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? authType;
  String? profileImage;
  int? isVerified;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  ClientDetails(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.address,
        this.authType,
        this.profileImage,
        this.isVerified,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    authType = json['auth_type'];
    profileImage = json['profile_image'];
    isVerified = json['is_verified'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['auth_type'] = this.authType;
    data['profile_image'] = this.profileImage;
    data['is_verified'] = this.isVerified;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
