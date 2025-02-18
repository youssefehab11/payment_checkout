import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment_checkout/core/utils/result.dart';

class MySnackbar {
  static void buildSnackbar(
    BuildContext context,
    Failure? failure,
    ServerError? serverError,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          extractErrorMessage(failure: failure, serverError: serverError),
        ),
      ),
    );
  }

  static String extractErrorMessage({
    Failure? failure,
    ServerError? serverError,
  }) {
    String message = 'Something went wrong';
    if (failure != null) {
      message = failure.exception.toString();
      log('Failure >>>>>>>>>>>>>> $message');
    } else if (serverError != null) {
      message = serverError.error.message ?? message;
      log('Server Error >>>>>>>>>>>>>> $message');
    }

    return message;
  }
}
