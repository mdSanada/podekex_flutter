import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:podekex_flutter/circular_progress/circular_progress.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/models/pokeapiv2.dart';
import 'package:podekex_flutter/models/specie.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:podekex_flutter/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

class AboutTab extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 70,
                      child: SingleChildScrollView(
                        child: Text(
                          _specie.flavorTextEntries
                              .where((element) => element.language.name == 'en')
                              .first
                              .flavorText
                              .replaceAll("\n", " ")
                              .replaceAll("\f", " ")
                              .replaceAll("POKéMON", "Pokémon"),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Biology',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Height',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Google',
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              _pokeApiStore.currentPokemon.height,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Google',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Google',
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              _pokeApiStore.currentPokemon.weight,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Google',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            : CircularProgress();
      }),
    );
  }
}
