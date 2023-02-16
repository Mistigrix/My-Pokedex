import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_pokedex/models/pokemon.dart';


Future<List> getPokeData() async {
  final API_URL = Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=50");

  final response = await http.get(API_URL);

  if (response.statusCode == 200) {
    final List<dynamic> pokemons_list = jsonDecode(response.body)['results'];
    return pokemons_list;
  } else {
    throw Exception("error");
  }
}


Future<List<Pokemon>> fetchAllPokemon() async {
   final poke_data = await getPokeData();
    late List<Pokemon> poke_list = [];

    for (var pokemon in poke_data) {
      poke_list.add(await fetchPokemon(pokemon['name']));
    }

    return poke_list;
}

Future<Pokemon> fetchPokemon(String name) async {
  final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/" + name));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error !");
  }
}

