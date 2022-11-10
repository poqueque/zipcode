import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_code.dart';

class PostCodeService {
  String currentValue = "";

  String urlCode(String zipCode) => "https://api.zippopotam.us/es/$zipCode";
  String urlPlace(String place) => "https://api.zippopotam.us/es/ct/$place";

  Future<List<PostCode>> fetchPlaces(String anyString) async {
    if (int.tryParse(anyString) != null && anyString.length == 5) {
      return fetchPlacesFromZip(anyString);
    }
    if (int.tryParse(anyString) == null && anyString.length > 3) {
      return fetchPlacesFromText(anyString);
    }
    return Future.error("Introdueix 5 números per buscar per codi postal o 4 lletres per buscar per text");
  }

  Future<List<PostCode>> fetchPlacesFromZip(String zipCode) async {
    http.Response response = await http.get(Uri.parse(urlCode(zipCode)));
    List<PostCode> postCodeList = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      postCodeList.add(PostCode.fromJson(data));
    }
    if (currentValue == zipCode) {
      if (postCodeList.isEmpty) {
        return Future.error("No hi ha resultats pel codi $zipCode");
      } else {
        return postCodeList;
      }
    } else {
      //We indicate that result should be ignored
      return Future.error("");
    }
  }

  Future<List<PostCode>> fetchPlacesFromText(String text) async {
    var response = await http.get(Uri.parse(urlPlace(text)));
    List<PostCode> postCodeList = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      postCodeList.add(PostCode.fromJson(data));
    }

    if (currentValue == text) {
      if (postCodeList.isEmpty) {
        return Future.error("No hi ha resultats pel text $text");
      } else {
        return postCodeList;
      }
    } else {
      return Future.error("");
    }
  }
}
