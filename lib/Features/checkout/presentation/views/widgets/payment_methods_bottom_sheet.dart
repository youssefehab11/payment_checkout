import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/Features/checkout/data/models/payment_intent_input.dart';
import 'package:payment_checkout/Features/checkout/data/repository/checkout_repo_impl.dart';
import 'package:payment_checkout/Features/checkout/presentation/view_model/payment_view_model.dart';
import 'package:payment_checkout/Features/checkout/presentation/view_model/payment_view_model_state.dart';
import 'package:payment_checkout/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payment_checkout/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:payment_checkout/core/widgets/custom_button.dart';
import 'package:payment_checkout/core/widgets/snackbar.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  bool isPaypal = false;
  late PaymentViewModel viewModel;

  updatePaymentMethod({required int index}) {
    if (index == 0) {
      isPaypal = false;
    } else {
      isPaypal = true;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    viewModel = PaymentViewModel(repo: CheckoutRepoImpl());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<PaymentViewModel, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ThankYouView()),
              );
            }
            if (state is PaymentError) {
              Navigator.pop(context);
              MySnackbar.buildSnackbar(context, state.error, state.serverError);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                PaymentMethodsListView(
                  updatePaymentMethod: updatePaymentMethod,
                ),
                const SizedBox(height: 32),
                state is PaymentLoading
                    ? CircularProgressIndicator(
                      color: Color(0xFF34A853),
                      padding: EdgeInsets.all(16),
                    )
                    : CustomButton(
                      text: "Pay",
                      onTap: () {
                        PaymentIntentInput paymentIntentInput =
                            PaymentIntentInput(amount: 50, currency: 'egp');
                        viewModel.makePayment(
                          paymentIntentInput: paymentIntentInput,
                        );
                      },
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
