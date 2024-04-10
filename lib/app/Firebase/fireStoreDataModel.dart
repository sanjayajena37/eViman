import 'package:cloud_firestore/cloud_firestore.dart';

class HelpCenter {
  String? name;
  String? email;

  HelpCenter({
    required this.name,
    required this.email,
  });

  HelpCenter.fromJson(Map<String, Object?> json)
      : this(
    name: json['number']! as String,
    email: json['email']! as String,
  );

  HelpCenter copyWith({
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
  }) {
    return HelpCenter(
        name: task ?? this.name,
        email: email ?? this.email);
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}