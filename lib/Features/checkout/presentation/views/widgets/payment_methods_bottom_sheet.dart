import 'package:flutter/material.dart';
import 'package:payment_checkout/Features/checkout/presentation/views/payment_details.dart';
import 'package:payment_checkout/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:payment_checkout/core/widgets/custom_button.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  bool isPaypal = false;

  updatePaymentMethod({required int index}) {
    if (index == 0) {
      isPaypal = false;
    } else {
      isPaypal = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          PaymentMethodsListView(updatePaymentMethod: updatePaymentMethod),
          const SizedBox(height: 32),
          CustomButton(
            text: "Pay",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PaymentDetailsView();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
