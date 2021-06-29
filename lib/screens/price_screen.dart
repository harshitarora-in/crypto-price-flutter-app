import 'package:crypto_price/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  bool isWaiting = false;
  Map<String, String> coinPrices = {};

  void getData() async {
    isWaiting = true;
    try {
      NetworkHelper networkHelper = NetworkHelper();
      var data = await networkHelper.getCoinData(selectedCurrency!);
      isWaiting = false;
      setState(() {
        coinPrices = data;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItem.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosDropdown() {
    List<Text> iosCurrency = [];
    for (String currency in currenciesList) {
      iosCurrency.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: iosCurrency);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(children: [
                  PriceCard(
                      cryptoCurrency: 'BTC',
                      priceInCurrency: isWaiting ? '?' : coinPrices['BTC'],
                      selectedCurrency: selectedCurrency),
                  Container(color: Colors.white, height: 3.0),
                  PriceCard(
                      cryptoCurrency: 'ETH',
                      priceInCurrency: isWaiting ? '?' : coinPrices['ETH'],
                      selectedCurrency: selectedCurrency),
                  Container(color: Colors.white, height: 3.0),
                  PriceCard(
                      cryptoCurrency: 'LTC',
                      priceInCurrency: isWaiting ? '?' : coinPrices['LTC'],
                      selectedCurrency: selectedCurrency),
                ])),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosDropdown() : androidDropdown(),
          )
        ],
      ),
    );
  }
}

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
