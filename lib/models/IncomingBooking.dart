/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the IncomingBooking type in your schema. */
class IncomingBooking extends amplify_core.Model {
  static const classType = const _IncomingBookingModelType();
  final String id;
  final int? _rider;
  final double? _clientLat;
  final double? _clientLng;
  final String? _clientName;
  final String? _clientPhone;
  final String? _clientId;
  final String? _fareInfo;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  IncomingBookingModelIdentifier get modelIdentifier {
      return IncomingBookingModelIdentifier(
        id: id
      );
  }
  
  int get rider {
    try {
      return _rider!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get clientLat {
    try {
      return _clientLat!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get clientLng {
    try {
      return _clientLng!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get clientName {
    try {
      return _clientName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get clientPhone {
    try {
      return _clientPhone!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get clientId {
    try {
      return _clientId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get fareInfo {
    try {
      return _fareInfo!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const IncomingBooking._internal({required this.id, required rider, required clientLat, required clientLng, required clientName, required clientPhone, required clientId, required fareInfo, createdAt, updatedAt}): _rider = rider, _clientLat = clientLat, _clientLng = clientLng, _clientName = clientName, _clientPhone = clientPhone, _clientId = clientId, _fareInfo = fareInfo, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory IncomingBooking({String? id, required int rider, required double clientLat, required double clientLng, required String clientName, required String clientPhone, required String clientId, required String fareInfo}) {
    return IncomingBooking._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      rider: rider,
      clientLat: clientLat,
      clientLng: clientLng,
      clientName: clientName,
      clientPhone: clientPhone,
      clientId: clientId,
      fareInfo: fareInfo);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IncomingBooking &&
      id == other.id &&
      _rider == other._rider &&
      _clientLat == other._clientLat &&
      _clientLng == other._clientLng &&
      _clientName == other._clientName &&
      _clientPhone == other._clientPhone &&
      _clientId == other._clientId &&
      _fareInfo == other._fareInfo;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("IncomingBooking {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("rider=" + (_rider != null ? _rider!.toString() : "null") + ", ");
    buffer.write("clientLat=" + (_clientLat != null ? _clientLat!.toString() : "null") + ", ");
    buffer.write("clientLng=" + (_clientLng != null ? _clientLng!.toString() : "null") + ", ");
    buffer.write("clientName=" + "$_clientName" + ", ");
    buffer.write("clientPhone=" + "$_clientPhone" + ", ");
    buffer.write("clientId=" + "$_clientId" + ", ");
    buffer.write("fareInfo=" + "$_fareInfo" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  IncomingBooking copyWith({int? rider, double? clientLat, double? clientLng, String? clientName, String? clientPhone, String? clientId, String? fareInfo}) {
    return IncomingBooking._internal(
      id: id,
      rider: rider ?? this.rider,
      clientLat: clientLat ?? this.clientLat,
      clientLng: clientLng ?? this.clientLng,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientId: clientId ?? this.clientId,
      fareInfo: fareInfo ?? this.fareInfo);
  }
  
  IncomingBooking copyWithModelFieldValues({
    ModelFieldValue<int>? rider,
    ModelFieldValue<double>? clientLat,
    ModelFieldValue<double>? clientLng,
    ModelFieldValue<String>? clientName,
    ModelFieldValue<String>? clientPhone,
    ModelFieldValue<String>? clientId,
    ModelFieldValue<String>? fareInfo
  }) {
    return IncomingBooking._internal(
      id: id,
      rider: rider == null ? this.rider : rider.value,
      clientLat: clientLat == null ? this.clientLat : clientLat.value,
      clientLng: clientLng == null ? this.clientLng : clientLng.value,
      clientName: clientName == null ? this.clientName : clientName.value,
      clientPhone: clientPhone == null ? this.clientPhone : clientPhone.value,
      clientId: clientId == null ? this.clientId : clientId.value,
      fareInfo: fareInfo == null ? this.fareInfo : fareInfo.value
    );
  }
  
  IncomingBooking.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _rider = (json['rider'] as num?)?.toInt(),
      _clientLat = (json['clientLat'] as num?)?.toDouble(),
      _clientLng = (json['clientLng'] as num?)?.toDouble(),
      _clientName = json['clientName'],
      _clientPhone = json['clientPhone'],
      _clientId = json['clientId'],
      _fareInfo = json['fareInfo'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'rider': _rider, 'clientLat': _clientLat, 'clientLng': _clientLng, 'clientName': _clientName, 'clientPhone': _clientPhone, 'clientId': _clientId, 'fareInfo': _fareInfo, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'rider': _rider,
    'clientLat': _clientLat,
    'clientLng': _clientLng,
    'clientName': _clientName,
    'clientPhone': _clientPhone,
    'clientId': _clientId,
    'fareInfo': _fareInfo,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<IncomingBookingModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<IncomingBookingModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final RIDER = amplify_core.QueryField(fieldName: "rider");
  static final CLIENTLAT = amplify_core.QueryField(fieldName: "clientLat");
  static final CLIENTLNG = amplify_core.QueryField(fieldName: "clientLng");
  static final CLIENTNAME = amplify_core.QueryField(fieldName: "clientName");
  static final CLIENTPHONE = amplify_core.QueryField(fieldName: "clientPhone");
  static final CLIENTID = amplify_core.QueryField(fieldName: "clientId");
  static final FAREINFO = amplify_core.QueryField(fieldName: "fareInfo");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "IncomingBooking";
    modelSchemaDefinition.pluralName = "IncomingBookings";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.RIDER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.CLIENTLAT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.CLIENTLNG,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.CLIENTNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.CLIENTPHONE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.CLIENTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: IncomingBooking.FAREINFO,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _IncomingBookingModelType extends amplify_core.ModelType<IncomingBooking> {
  const _IncomingBookingModelType();
  
  @override
  IncomingBooking fromJson(Map<String, dynamic> jsonData) {
    return IncomingBooking.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'IncomingBooking';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [IncomingBooking] in your schema.
 */
class IncomingBookingModelIdentifier implements amplify_core.ModelIdentifier<IncomingBooking> {
  final String id;

  /** Create an instance of IncomingBookingModelIdentifier using [id] the primary key. */
  const IncomingBookingModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'IncomingBookingModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is IncomingBookingModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}