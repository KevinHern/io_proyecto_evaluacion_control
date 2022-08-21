import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:http/http.dart' as http;

class PythonServerDatasource {
  static const String serverURL =
      "https://limitless-shelf-76580.herokuapp.com/ejemplo";
  Future<OperationResult> sendJsonToServer(
      {required String encodedObject}) async {
    try {
      final response = await http.post(
        Uri.parse(serverURL),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: encodedObject,
      );

      if (response.statusCode == 200) {
        return OperationResult(
          success: true,
          message: "Cálculos realizados con éxito",
          returnedObject: response.body,
        );
      } else {
        return OperationResult(
            success: false,
            message:
                "Ocurrió un error. Código de error ${response.statusCode}");
      }
    } catch (error) {
      return OperationResult(
          success: false,
          message:
              "Ocurrió un error al pedir los cálculos: ${error.toString()}");
    }
  }
}
