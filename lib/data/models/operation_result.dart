class OperationResult {
  final bool success;
  final String? message;
  final Object? returnedObject;

  OperationResult({required this.success, this.message, this.returnedObject});
}
