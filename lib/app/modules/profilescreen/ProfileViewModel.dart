class ProfileViewModel {
  bool? success;
  String? message;
  RiderData? riderData;

  ProfileViewModel({this.success, this.message, this.riderData});

  ProfileViewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    riderData = json['riderData'] != null
        ? new RiderData.fromJson(json['riderData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.riderData != null) {
      data['riderData'] = this.riderData!.toJson();
    }
    return data;
  }
}

class RiderData {
  int? id;
  String? referralCode;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  int? pin;
  String? drivingLicenseNo;
  String? dlImage;
  String? profile_image;
  String? aadhaar_image;
  String? pan_image;
  bool? isVerified;
  bool? isActive;
  bool? isOnline;
  String? createdAt;
  String? updatedAt;

  RiderData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.pin,
        this.drivingLicenseNo,
        this.dlImage,
        this.isVerified,
        this.isActive,
        this.isOnline,
        this.createdAt,
        this.updatedAt,
        this.profile_image,
        this.aadhaar_image,
        this.pan_image,this.referralCode});

  RiderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
    drivingLicenseNo = json['driving_license_no'];
    dlImage = json['dl_image'];
    profile_image = json['profile_image'];
    aadhaar_image = json['aadhaar_image'];
    pan_image = json['pan_image'];
    isVerified = json['is_verified'];
    isActive = json['is_active'];
    isOnline = json['is_online'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    referralCode = json['referralCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    data['driving_license_no'] = this.drivingLicenseNo;
    data['dl_image'] = this.dlImage;
    data['profile_image'] = this.profile_image;
    data['aadhaar_image'] = this.aadhaar_image;
    data['pan_image'] = this.pan_image;
    data['is_verified'] = this.isVerified;
    data['is_active'] = this.isActive;
    data['is_online'] = this.isOnline;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['referralCode'] = this.referralCode;
    return data;
  }
}
