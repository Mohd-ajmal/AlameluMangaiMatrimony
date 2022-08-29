// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matrimony/model/SearchFilterModel.dart';

class Services {
  static String name = '';

  static Future<List<SearchFilterModel>> getUserSuggestion(String query) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      final List suggestionList = json.decode(reponse.body);
      return suggestionList
          .map((e) => SearchFilterModel.fromJson(e))
          .where((element) {
        final nameLower = element.data.username;
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<SearchFilterModel>> postUserId(String id) async {
    final url = Uri.parse(
        'http://rbsreadymadesteel.com/tmclone.in/api/v1/search/search-by-id');
    final reponse = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 9|pZm3kKLBCnxtO4LG1tzsA14LlfqVqK0AlTBTZ9qs',
      },
      body: {"profile_id": id},
    );
    if (reponse.statusCode == 200) {
      //print(reponse.body);

      Map<String, dynamic> resBody = json.decode(reponse.body);
      Map<String, dynamic> resbody2 = resBody['data'];
      //print(resbody2);
      List data = resbody2.entries
          .map((entry) => searchFilterModelFromJson(entry.toString()))
          .toList();

//      print(name);
      return data.map((e) => searchFilterModelFromJson(e)).where((element) {
        return element.data.profileId.contains(id);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
