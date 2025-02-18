import 'package:payment_checkout/core/utils/result.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentError extends PaymentState {
  final Failure? error;
  final ServerError? serverError;
  PaymentError({this.error, this.serverError});
}
