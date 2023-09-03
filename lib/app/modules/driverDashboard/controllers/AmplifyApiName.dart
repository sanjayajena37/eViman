import 'package:amplify_flutter/amplify_flutter.dart';

class AmplifyApiName {
  static String iam = '';
  static String defaultApi = '';
  static String apiKey = '';
  static String userPool = '';

  static init() async {
    AmplifyConfig config = await Amplify.asyncConfig;
    var apis = config.auth?.awsPlugin?.appSync?.all;
    iam = apis?.keys.firstWhere((key) => key.contains('AWS_IAM')) ?? '';
    defaultApi = apis?.keys.firstWhere((key) => key.contains('Default')) ?? '';
    userPool = apis?.keys.firstWhere((key) => key.contains('USER_POOLS')) ?? '';
    apiKey = apis?.keys.firstWhere((key) => key.contains('API_KEY')) ?? '';
  }
}
