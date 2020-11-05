import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/champion.dart';

class LolService {
  static LolService _instance;
  static LolService get instance => _instance;

  final String _baseUrl;
  final String _avatarUrl;

  LolService._(this._baseUrl, this._avatarUrl);

  static Future<void> init() async {
    if (_instance == null) {
      final url = 'https://ddragon.leagueoflegends.com/api/versions.json';
      final response = await http.get(url);
      final version = (jsonDecode(response.body) as List).first;

      _instance = LolService._(
        'http://ddragon.leagueoflegends.com/cdn/$version/data/en_US',
        'http://ddragon.leagueoflegends.com/cdn/$version/img/champion',
      );
    }
  }

  Future<List<Champion>> getChampions() async {
    final url = '$_baseUrl/champion.json';
    final response = await http.get(url);
    final data = jsonDecode(response.body)['data'] as Map;

    return data.values
        .map(
          (map) => Champion.fromMap(map, '$_avatarUrl/${map['image']['full']}'),
        )
        .toList();
  }

  Future<Champion> getChampion(String id) async {
    final url = '$_baseUrl/champion/$id.json';
    final response = await http.get(url);
    final data = jsonDecode(response.body)['data'] as Map;

    return Champion.fromMap(data[id], null);
  }
}
