import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/Features/checkout/data/models/payment_intent_input.dart';
import 'package:payment_checkout/Features/checkout/data/repository/checkout_repo.dart';
import 'package:payment_checkout/Features/checkout/presentation/view_model/payment_view_model_state.dart';
import 'package:payment_checkout/core/utils/result.dart';

class PaymentViewModel extends Cubit<PaymentState> {
  final CheckoutRepo repo;
  PaymentViewModel({required this.repo}) : super(PaymentInitial());

  void makePayment({required PaymentIntentInput paymentIntentInput}) async {
    emit(PaymentLoading());
    Result result = await repo.makePayment(
      paymentIntentInput: paymentIntentInput,
    );

    switch (result) {
      case Success():
        emit(PaymentSuccess());
      case Failure():
        emit(PaymentError(error: result));
      case ServerError():
        emit(PaymentError(serverError: result));
    }
  }

  @override
  void onChange(Change<PaymentState> change) {
    log('Current State: $change');
    super.onChange(change);
  }
}
