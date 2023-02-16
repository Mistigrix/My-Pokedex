import 'package:flutter/material.dart';
import 'package:my_pokedex/pages/pokemon_detail.dart';
import 'package:my_pokedex/request.dart';

import '../models/pokemon.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pokemon>> future_poke_list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future_poke_list = fetchAllPokemon();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: future_poke_list,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final poke_list = snapshot.data!;

          return ListView.builder(
            itemCount: poke_list.length,
            itemBuilder: (context, index) {
              final poke = poke_list[index];
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    leading: Image.network(poke.sprite),
                    title: Text(poke.name),
                    subtitle: Text("TYPE: " + poke.type),
                    trailing: GestureDetector(
                        onTap: () =>{ print("Tap on icon more_vert")},
                        child: Icon(Icons.more_vert)
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PokemonDetail(name: poke.name)
                  ));
                },
              );
            },
          );
        } else if(snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.red),));
        }

        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
