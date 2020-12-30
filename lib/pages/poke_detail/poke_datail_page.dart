import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_api.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;
  final String name;

  const PokeDetailPage({Key key, this.index, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.getPokemon(index: index);
    return Scaffold(
      backgroundColor: ConstsAPI.getColorType(type: _pokemon.type.first),
    );
  }
}
