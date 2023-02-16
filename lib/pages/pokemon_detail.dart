import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_pokedex/request.dart';

import '../models/pokemon.dart';


class PokemonDetail extends StatefulWidget {
  const PokemonDetail({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  late Future<Pokemon> future_pokemon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future_pokemon = fetchPokemon("charizard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          title: Text("Detail"),
          onSearch: (value) => { print("Search") }
      ),
      body: FutureBuilder<Pokemon>(
        future: future_pokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return Center(
              child: Text("This is a " + pokemon.name)
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
}
