abstract class CustomException implements Exception {
  final String message;

  const CustomException(this.message);
}
class ServerException extends CustomException {
  const ServerException(super.message);
}

class DioNetworkException extends CustomException {
  const DioNetworkException(super.message);
}
