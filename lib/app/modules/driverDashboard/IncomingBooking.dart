

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/// This is an auto generated class representing the Comment type in your schema.
@immutable
class InComingBooking extends Model {
  static const classType = _CommentModelType();
  final String rider;
  final String? clientLat;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => rider;

  CommentModelIdentifier get modelIdentifier {
    return CommentModelIdentifier(id: rider);
  }



  String get content {
    try {
      return clientLat!;
    } catch (e) {
      throw AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }


  const InComingBooking._internal(
      {required this.rider, required content,  clientLat,})
      :
        clientLat = content;

  factory InComingBooking({String? id, required String content,String? clientLat,String? clientLng}) {
    return InComingBooking._internal(
        rider: id == null ? UUID.getUUID() : id, content: content,clientLat: clientLat, );
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InComingBooking &&
        rider == other.rider &&
        clientLat == other.clientLat;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = StringBuffer();

    buffer.write("Comment {");
    buffer.write("rider=" + "$rider" + ", ");
    buffer.write("content=" + "$clientLat" + ", ");
    buffer.write("}");

    return buffer.toString();
  }

  InComingBooking copyWith({ String? content}) {
    return InComingBooking._internal(
        rider: rider, content: content ?? this.content);
  }

  InComingBooking.fromJson(Map<String, dynamic> json,)
      : rider = json['id'],
        clientLat = json['content'];

  Map<String, dynamic> toJson() => {
    'rider': rider,
    'content': clientLat,
  };

  Map<String, Object?> toMap() => {
    'rider': rider,
    'content': clientLat,
  };

  static final QueryModelIdentifier<CommentModelIdentifier> MODEL_IDENTIFIER =
  QueryModelIdentifier<CommentModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "rider");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static var schema =
  Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE,
          provider: AuthRuleProvider.IAM,
          operations: [ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE,
          provider: AuthRuleProvider.USERPOOLS,
          operations: [ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [
            ModelOperation.CREATE,
            ModelOperation.READ,
            ModelOperation.UPDATE,
            ModelOperation.DELETE
          ])
    ];

    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["postID"], name: "byPost")
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: InComingBooking.CONTENT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _CommentModelType extends ModelType<InComingBooking> {
  const _CommentModelType();

  @override
  InComingBooking fromJson(Map<String, dynamic> jsonData) {
    return InComingBooking.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Comment';
  }
}

/// This is an auto generated class representing the model identifier
/// of [InComingBooking] in your schema.
@immutable
class CommentModelIdentifier implements ModelIdentifier<InComingBooking> {
  final String id;

  /// Create an instance of CommentModelIdentifier using [id] the primary key.
  const CommentModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'CommentModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CommentModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}