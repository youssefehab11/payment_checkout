import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/Features/checkout/data/models/error_response.dart';
import 'package:payment_checkout/Features/checkout/data/models/payment_intent_input.dart';
import 'package:payment_checkout/Features/checkout/data/repository/checkout_repo.dart';
import 'package:payment_checkout/core/services/stripe_service.dart';
import 'package:payment_checkout/core/utils/result.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  StripeService stripeService = StripeService();
  @override
  Future<Result> makePayment({
    required PaymentIntentInput paymentIntentInput,
  }) async {
    try {
      await stripeService.makePayment(paymentIntentInput);
      return Success();
    } on DioException catch (ex) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(ex.response!.data);
      return ServerError(error: errorResponse.error ?? Error());
    } on StripeException catch (ex) {
      Error error = Error.fromJson(ex.error.toJson());

      return ServerError(error: error);
    } on Exception catch (ex) {
      return Failure(exception: ex);
    }
  }
}
