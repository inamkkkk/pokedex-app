import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon.dart';

class PokemonService extends ChangeNotifier {
  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPokemonList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];

        _pokemonList = [];
        for (var result in results) {
          final pokemonDetailsResponse = await http.get(Uri.parse(result['url']));
          if (pokemonDetailsResponse.statusCode == 200) {
            final pokemonDetails = jsonDecode(pokemonDetailsResponse.body);
            _pokemonList.add(Pokemon.fromJson(pokemonDetails));
          }
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching Pokemon: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
