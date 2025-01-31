class ApiErrorModel {
  final String status;
  final String code;
  final String message;

  const ApiErrorModel(
      {required this.status, required this.code, required this.message});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        status: json['status'],
        code: json['code'],
        message: json['message'],
      );
}
