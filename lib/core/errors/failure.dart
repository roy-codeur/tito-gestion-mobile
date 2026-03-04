abstract class Failure {
  final int? statusCode;
  final String? message;

  Failure(this.statusCode, this.message);

}

class AuthFailure extends Failure {
  AuthFailure(super.statusCode, super.message);
  factory AuthFailure.fromStatusCode(int statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return AuthFailure(statusCode, 'Bad request: $message');
      case 401:
        return AuthFailure(statusCode, 'Unauthorized: mots de passe ou email incorrect');
      case 403:
        return AuthFailure(statusCode, 'Forbidden: $message');
      case 404:
        return AuthFailure(statusCode, 'Not found: $message');
      case 500:
        return AuthFailure(statusCode, 'Internal server error: $message');
      default:
        return AuthFailure(statusCode, 'Unexpected error: $message');
    }
  }
}