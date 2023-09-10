class IncomingBooikingModel {
  IncomingBooking? incomingBooking;

  IncomingBooikingModel({this.incomingBooking});

  IncomingBooikingModel.fromJson(Map<String, dynamic> json) {
    incomingBooking = json['incomingBooking'] != null
        ? new IncomingBooking.fromJson(json['incomingBooking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.incomingBooking != null) {
      data['incomingBooking'] = this.incomingBooking!.toJson();
    }
    return data;
  }
}

class IncomingBooking {
  int? rider;
  String? clientLat;
  String? clientLng;
  String? clientName;
  String? clientPhone;
  int? clientId;
  int? fareInfo;
  String? bookingId;
  String? destinationLat;
  String? destinationLng;
  String? dropAddress;
  String? pickupAddress;
  String? status;

  IncomingBooking(
      {this.rider,
        this.clientLat,
        this.clientLng,
        this.clientName,
        this.clientPhone,
        this.clientId,
        this.fareInfo,
        this.bookingId,
        this.destinationLat,
        this.destinationLng,
        this.dropAddress,
        this.pickupAddress,this.status});

  IncomingBooking.fromJson(Map<String, dynamic> json) {
    rider = json['rider'];
    clientLat = json['clientLat'];
    clientLng = json['clientLng'];
    clientName = json['clientName'];
    clientPhone = json['clientPhone'];
    clientId = json['clientId'];
    fareInfo = json['fareInfo'];
    bookingId = json['bookingId'];
    destinationLat = json['destinationLat'];
    destinationLng = json['destinationLng'];
    dropAddress = json['dropAddress'];
    pickupAddress = json['pickupAddress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rider'] = this.rider;
    data['clientLat'] = this.clientLat;
    data['clientLng'] = this.clientLng;
    data['clientName'] = this.clientName;
    data['clientPhone'] = this.clientPhone;
    data['clientId'] = this.clientId;
    data['fareInfo'] = this.fareInfo;
    data['bookingId'] = this.bookingId;
    data['destinationLat'] = this.destinationLat;
    data['destinationLng'] = this.destinationLng;
    data['dropAddress'] = this.dropAddress;
    data['pickupAddress'] = this.pickupAddress;
    data['status'] = this.status;
    return data;
  }
}
