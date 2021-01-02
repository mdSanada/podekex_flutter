import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CircularProgress extends StatelessWidget {
final PokeApiStore _pokemonStore = GetIt.instance<PokeApiStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    _pokemonStore.pokemonColor),
              )),
        ),
      ],
    );
  }
}
