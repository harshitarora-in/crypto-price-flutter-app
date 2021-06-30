import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    required this.cryptoCurrency,
    required this.priceInCurrency,
    required this.selectedCurrency,
  });

  final String? priceInCurrency;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
      child: Text(
        '1 $cryptoCurrency = $priceInCurrency $selectedCurrency',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
