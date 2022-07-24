import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:http/http.dart' as http;

class PythonServerDatasource {
  Future<OperationResult> getLearningCurveValues(
      {required String url, required String encodedLearningCurve}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: encodedLearningCurve,
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
