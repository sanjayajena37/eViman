import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_connect/connect.dart';

import 'package:dio/dio.dart' as service;

import '../data/Const.dart';

class ConnectorController extends GetConnect {
  late Dio dio;
  String? accessToken = "";
  String? appMode = "";

  @override
  void onInit() {
    dio = Dio();
    super.onInit();
  }

  Map<String, dynamic> failedMap = {
    Const.STATUS: Const.FAILED,
    Const.MESSAGE: Const.NETWORK_ISSUE,
  };
  Map<String, dynamic> alreadyMap = {
    Const.STATUS: Const.FAILED,
    Const.MESSAGE: "Already Available",
  };

  updateToken() {}

  GETMETHODCALL({required String api, required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.get(api);
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 500) {
        print("MI II>>" + response.data.toString());
        fun(response.data);
      } else {
        print("MI II>>" + response.data.toString());
        fun(failedMap);
      }
    } on DioError catch (e) {
      //log("Connector Response Error>>" + jsonEncode(e.message));
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data ?? "");
      }
    }
  }

  PATCHMETHODCALL(
      {required String api, dynamic? json, required Function fun}) async {
    try {
      print("API NAME:>" + api);
      service.Response response = await dio.patch(
        api,
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  GETMETHOD_CALL_LOGIN(
      {required String api, required Function fun, Function? failed}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.get(api,
          options: Options(headers: {"Access-Control-Allow-Origin": "*"}));
      if (response.statusCode == 200) {
        try {
          fun(response.data);
          // log("Connector Response" + jsonEncode(response.data));
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        failed!(failedMap);
      }
    } on DioError catch (e) {
      log("Connector Response Error>>" + jsonEncode(e.message));
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          failed!(failedMap);
          break;
        case DioErrorType.response:
          failed!(e.response?.data);
      }
    }
  }

  DELTETEMETHODCALL({required String api, required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.delete(api,
          options: Options(headers: {"Access-Control-Allow-Origin": "*"}));
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  GETMETHOD_LANG({required String api, required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.get(api);
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  GETMETHODCALL_TOKEN(
      {required String api,
      required String token,
      required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    print("Token NAME:>" + token);
    try {
      service.Response response = await dio.get(
        api,
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : ""),
        }),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  DELETE_METHOD_TOKEN(
      {required String api,
      required String token,
      required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.delete(
        api,
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : ""),
        }),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  DELETE_METHOD_DATA_TOKEN(
      {required String api,
      required String token,
      required var post,
      required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.delete(
        api,
        data: jsonEncode(post),
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : ""),
        }),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  PUTMETHODCALL_TOKEN(
      {required String api,
      required String token,
      required post,
      required Function fun}) async {
    print("<<>>>>>API CALL>>>>>>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + api);
    try {
      service.Response response = await dio.put(
        api,
        data: jsonEncode(post),
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : ""),
        }),
      );
      if (response.statusCode == 200) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else {
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  POSTMETHOD(
      {required String api, dynamic? json, required Function fun}) async {
    try {
      print("API NAME:>" + api);
      service.Response response = await dio.post(
        api,
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  POSTMETHOD1(
      {required String api, dynamic? json, required Function fun}) async {
    try {
      print("API NAME:>" + api);
      service.Response response = await dio.post(
        api,
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun([]);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun([]);
          break;
        case DioErrorType.response:
          fun([]);
      }
    }
  }

  POSTMETHOD_TOKEN(
      {required String api,
      required String token,
      dynamic? json,
      required Function fun}) async {
    try {
      print("API NAME:>" + api);
      print("Token NAME:>" + token);
      service.Response response = await dio.post(
        api,
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : "")
        }),
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  PATCH_METHOD_TOKEN(
      {required String api,
        required String token,
        dynamic? json,
        required Function fun}) async {
    try {
      print("API NAME:>" + api);
      print("Token NAME:>" + token);
      service.Response response = await dio.patch(
        api,
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : "")
        }),
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

  PATCH_METHOD_POST_TOKEN(
      {required String api,
        required String token,
        dynamic? json,
        required Function fun}) async {
    try {
      print("API NAME:>" + api);
      print("Token NAME:>" + token);
      service.Response response = await dio.put(
        api,
        options: Options(headers: {
          "Authorization": "Bearer " + ((token != null) ? token : "")
        }),
        data: (json != null) ? jsonEncode(json) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fun(response.data);
        } catch (e) {
          print("Message is: " + e.toString());
        }
      } else if (response.statusCode == 417) {
        fun(response.data);
      } else {
        print("Message is: >>1");
        fun(failedMap);
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.cancel:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.other:
          fun(failedMap);
          break;
        case DioErrorType.response:
          fun(e.response?.data);
      }
    }
  }

}
