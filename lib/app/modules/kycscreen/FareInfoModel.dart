class FareInfoModel {
  bool? success;
  String? message;
  List<FareList>? fareList;

  FareInfoModel({this.success, this.message, this.fareList});

  FareInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['fareList'] != null) {
      fareList = <FareList>[];
      json['fareList'].forEach((v) {
        fareList!.add(new FareList.fromJson(v));
      });
    }else{
      fareList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.fareList != null) {
      data['fareList'] = this.fareList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FareList {
  int? id;
  String? vehicleType;
  String? vehicleSubType;
  String? baseFare;
  String? farePerMin;
  String? farePerKm;
  String? city;
  int? isDeleted;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  FareList(
      {this.id,
        this.vehicleType,
        this.vehicleSubType,
        this.baseFare,
        this.farePerMin,
        this.farePerKm,
        this.city,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  FareList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleType = json['vehicle_type'];
    vehicleSubType = json['vehicle_sub_type'];
    baseFare = json['base_fare'];
    farePerMin = json['fare_per_min'];
    farePerKm = json['fare_per_km'];
    city = json['city'];
    isDeleted = json['is_deleted'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_sub_type'] = this.vehicleSubType;
    data['base_fare'] = this.baseFare;
    data['fare_per_min'] = this.farePerMin;
    data['fare_per_km'] = this.farePerKm;
    data['city'] = this.city;
    data['is_deleted'] = this.isDeleted;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Vehicle {
  final int id;
  final String vehicleType;
  final String vehicleSubType;
  final String baseFare;
  final String farePerMin;
  final String farePerKm;
  final String city;
  final int isDeleted;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  Vehicle({
    required this.id,
    required this.vehicleType,
    required this.vehicleSubType,
    required this.baseFare,
    required this.farePerMin,
    required this.farePerKm,
    required this.city,
    required this.isDeleted,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      vehicleType: json['vehicle_type'],
      vehicleSubType: json['vehicle_sub_type'],
      baseFare: (json['base_fare']),
      farePerMin: (json['fare_per_min']),
      farePerKm: (json['fare_per_km']),
      city: json['city'],
      isDeleted: json['is_deleted'],
      isActive: json['is_active'],
      createdAt: (json['createdAt']),
      updatedAt: (json['updatedAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Vehicle &&
              runtimeType == other.runtimeType &&
              vehicleType == other.vehicleType;

  @override
  int get hashCode => vehicleType.hashCode;
}