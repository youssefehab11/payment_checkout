import 'package:payment_checkout/Features/checkout/data/models/error_response.dart';

sealed class Result {}

class Success extends Result {}

class ServerError extends Result {
  Error error;
  ServerError({required this.error});
}

class Failure extends Result {
  Exception exception;
  Failure({required this.exception});
}
