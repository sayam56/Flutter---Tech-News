import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/techNews.dart';

class ApiManager {
  Future<Welcome> getNews() async {
    //this function will return the model in the future
    var client = http.Client(); //opening a client

    var techModel;

    try {
      var response = await client.get(
          'http://newsapi.org/v2/everything?q=apple&from=2020-11-11&to=2020-11-11&sortBy=popularity&apiKey=a4dc41afdb73426fa86c93eb286000c6');

      if (response.statusCode == 200) {
        //the usual stattus checking
        var jsonBody = response.body; //self explanatory

        var jsonMap =
            json.decode(jsonBody); //decoding the body into a key=>value pair

        techModel = Welcome.fromJson(jsonMap);
        //here the model way created automatically by quicktype.io from the json data
        //here we are passing the key=>value pair to the model so that it can make it available to the front end
      } /* if ends */

    } catch (Exception) {
      return techModel;
    }

    return techModel;
  }
}
