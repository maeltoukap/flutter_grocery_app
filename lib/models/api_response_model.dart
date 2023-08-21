class APIResponse {
  var data;
  bool error;
  String? errorMessage;
  int? statusCode;
  // String? uid;
  APIResponse({
    this.data,
    this.errorMessage,
    this.error = true,
    this.statusCode,
  });
}
