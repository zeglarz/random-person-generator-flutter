import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  String url;

  Future getData({countryList, gender}) async {
    try {
      http.Response response = await http
          .get('${this.url}/?nat=${countryList.join(",")}&gender=$gender');
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
