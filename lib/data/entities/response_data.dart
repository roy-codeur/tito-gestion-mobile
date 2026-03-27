class ResponseData<T>{
  ResponseData(this.success, this.data, this.message, [this.code]);

  int? code;
  bool success;
  T? data;
  String message;

  bool get error => !success;

  factory ResponseData.customError({required String message, int? code}) => ResponseData(false, null, message, code);
  factory ResponseData.requestTimeout() => ResponseData(false, null, 'Limite de temps dépassée. Ressayez plus tard');
  factory ResponseData.noInternet() => ResponseData(false, null, 'Vérifiez votre connexion internet');
  factory ResponseData.success({data, String message = "Success"}) => ResponseData(true, data, message);

  factory ResponseData.fromSuccessResponse(dynamic body) => ResponseData(true, body['data'], body['message'] ?? 'success');
  factory ResponseData.fromErrorResponse(dynamic body) => ResponseData(false, body['data'], body['message'] ?? 'success', body['code']);
}