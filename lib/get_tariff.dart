import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var tariffTotalPrice, tariffCurr;

Future<void> getTariff() async {
  var jsonBody = json.encode("");
  var url = "https://client.apis.stage.faem.pro/api/v2/orders/tariff";
  var response =
      await http.post(url, body: jsonBody, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var responseTariffData = new TariffData.fromJson(jsonResponse);
    tariffTotalPrice = responseTariffData.tariffTotal_price;
    tariffCurr = responseTariffData.tariffCurrency;
    print(response.body);
  } else {
    print("Error with code ${response.statusCode}");
    print("${response.body}");
  }
}


class TariffData {
  var tariffTotal_price;
  final String tariffCurrency;

  TariffData({this.tariffTotal_price, this.tariffCurrency});

  factory TariffData.fromJson(Map<String, dynamic> parsedJson) {
    return TariffData(
      tariffTotal_price: parsedJson['total_price'],
      tariffCurrency: parsedJson['currency'] as String,
    );
  }
}
