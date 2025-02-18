import 'package:payment_checkout/Features/checkout/data/models/payment_intent_input.dart';
import 'package:payment_checkout/core/utils/result.dart';

abstract class CheckoutRepo {
  Future<Result> makePayment({required PaymentIntentInput paymentIntentInput});
}
