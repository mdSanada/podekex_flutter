import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:podekex_flutter/circular_progress/circular_progress.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/models/pokeapiv2.dart';
import 'package:podekex_flutter/models/specie.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:podekex_flutter/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

class EvolutionTab extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();

  Widget resizePokemon(Widget widget) {
    return SizedBox(
      height: 70,
      width: 70,
      child: widget,
    );
  }

  List<Widget> getEvolution() {
    Pokemon pokemon = _pokeApiStore.currentPokemon;
    List<Widget> _list = [];
    if (pokemon.prevEvolution != null) {
      pokemon.prevEvolution.forEach(
        (element) {
          _list.add(resizePokemon(_pokeApiStore.getImage(numero: element.num)));
          _list.add(Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              element.name,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Google',
                  fontWeight: FontWeight.bold),
            ),
          ));
          _list.add(resizePokemon(Icon(Icons.keyboard_arrow_down)));
        },
      );
    }
    _list.add(resizePokemon(_pokeApiStore.getImage(numero: pokemon.num)));
    _list.add(Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        pokemon.name,
        style: TextStyle(
            fontSize: 16, fontFamily: 'Google', fontWeight: FontWeight.bold),
      ),
    ));
    if (pokemon.nextEvolution != null) {
      pokemon.nextEvolution.forEach(
        (element) {
          _list.add(resizePokemon(Icon(Icons.keyboard_arrow_down)));
          _list.add(resizePokemon(_pokeApiStore.getImage(numero: element.num)));
          _list.add(Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              element.name,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Google',
                  fontWeight: FontWeight.bold),
            ),
          ));
        },
      );
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (context) {
        Specie _specie = _pokeApiV2Store.specie;
        PokeApiV2 _pokeApiV2 = _pokeApiV2Store.pokeApiV2;
        Pokemon _currentPokemon = _pokeApiStore.currentPokemon;

        return _specie != null && _currentPokemon != null && _pokeApiV2 != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: getEvolution(),
                  ),
                ),
              )
            : CircularProgress();
      }),
    );
  }
}
