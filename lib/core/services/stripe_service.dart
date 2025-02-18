import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_checkout/Features/checkout/data/models/payment_intent_input.dart';
import 'package:payment_checkout/Features/checkout/data/models/payment_intent_response/payment_intent_response.dart';
import 'package:payment_checkout/core/services/api_service.dart';
import 'package:payment_checkout/core/utils/api_keys.dart';

class StripeService {
  final ApiService _apiService = ApiService();
  Future<PaymentIntentResponse> createPaymentIntent(
    PaymentIntentInput paymentIntentInput,
  ) async {
    Response response = await _apiService.post(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentIntentInput.toJson(),
      apiKey: ApiKeys.secretKey,
    );
    PaymentIntentResponse paymentIntentResponse =
        PaymentIntentResponse.fromJson(response.data);
    return paymentIntentResponse;
  }

  Future<void> initPaymentSheet(String paymentIntentClientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'youssef',
        paymentIntentClientSecret: paymentIntentClientSecret,
      ),
    );
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(PaymentIntentInput paymentIntentInput) async {
    PaymentIntentResponse paymentIntentResponse = await createPaymentIntent(
      paymentIntentInput,
    );
    await initPaymentSheet(paymentIntentResponse.clientSecret!);
    await displayPaymentSheet();
  }
}
