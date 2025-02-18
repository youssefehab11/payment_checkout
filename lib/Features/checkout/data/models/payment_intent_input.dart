class PaymentIntentInput {
  final int amount;
  final String currency;

  PaymentIntentInput({required this.amount, required this.currency});
  Map<String, dynamic> toJson() {
    return {'amount': amount * 100, 'currency': currency};
  }
}
