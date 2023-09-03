class VehicleDetailsModel {
  bool? success;
  String? message;
  VehicleDetails? vehicleDetails;

  VehicleDetailsModel({this.success, this.message, this.vehicleDetails});

  VehicleDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    vehicleDetails = json['vehicleDetails'] != null
        ? new VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.vehicleDetails != null) {
      data['vehicleDetails'] = this.vehicleDetails!.toJson();
    }
    return data;
  }
}

class VehicleDetails {
  int? id;
  String? vehicleRegdNumber;
  String? chasisNumber;
  String? engineNumber;
  String? ownerName;
  String? rcImage;
  String? vehicleImage;
  String? insuranceImage;
  String? pollutionImage;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  int? pin;
  String? currentCity;
  String? lat;
  String? lng;
  int? isVerified;
  int? isOnline;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  VehicleDetails(
      {this.id,
        this.vehicleRegdNumber,
        this.chasisNumber,
        this.engineNumber,
        this.ownerName,
        this.rcImage,
        this.vehicleImage,
        this.insuranceImage,
        this.pollutionImage,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.pin,
        this.currentCity,
        this.lat,
        this.lng,
        this.isVerified,
        this.isOnline,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleRegdNumber = json['vehicle_regd_number'];
    chasisNumber = json['chasis_number'];
    engineNumber = json['engine_number'];
    ownerName = json['owner_name'];
    rcImage = json['rc_image'];
    vehicleImage = json['vehicle_image'];
    insuranceImage = json['insurance_image'];
    pollutionImage = json['pollution_image'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
    currentCity = json['current_city'];
    lat = json['lat'];
    lng = json['lng'];
    isVerified = json['is_verified'];
    isOnline = json['is_online'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_regd_number'] = this.vehicleRegdNumber;
    data['chasis_number'] = this.chasisNumber;
    data['engine_number'] = this.engineNumber;
    data['owner_name'] = this.ownerName;
    data['rc_image'] = this.rcImage;
    data['vehicle_image'] = this.vehicleImage;
    data['insurance_image'] = this.insuranceImage;
    data['pollution_image'] = this.pollutionImage;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    data['current_city'] = this.currentCity;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['is_verified'] = this.isVerified;
    data['is_online'] = this.isOnline;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
