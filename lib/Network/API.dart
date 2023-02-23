import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  Future<double> getRate(String from, String to,) async {
    final response = await http.get(Uri.https(
        "api.exchangerate.host", "/convert", {"from":from,"to":to}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['result']*1.0;
    } else {
      throw Exception('Failed to load currency');
    }
  }
}

class Currency {
  final double result;

  Currency({required this.result});

  factory Currency.fromJson(String json) {
    return Currency(
        result: double.parse(jsonDecode(json)['result'].toString()));
  }
}
