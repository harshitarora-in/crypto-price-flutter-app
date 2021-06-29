import 'package:http/http.dart' as http;
import 'dart:convert';

const String coinApi = 'F3FF9A95-72F4-446B-B881-1B8659F2045C';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class NetworkHelper {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/${currency.toUpperCase()}/?apikey=$coinApi'));
      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        double lastPrice = temp['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        print(cryptoPrices[crypto]);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}

//TODO recheck the whole code again
//TODO add getdata funtion in IOS dropdown
