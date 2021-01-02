import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:podekex_flutter/circular_progress/circular_progress.dart';
import 'package:podekex_flutter/models/specie.dart';
import 'package:podekex_flutter/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

class AboutTab extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
          Observer(builder: (context) {
            Specie _specie = _pokeApiV2Store.specie;
            return _specie != null
                ? Text(
              _specie.flavorTextEntries
                  .where(
                      (element) => element.language.name == 'en')
                  .first
                  .flavorText
                  .replaceAll("\n", " ")
                  .replaceAll("\f", " ")
                  .replaceAll("POKéMON", "Pokémon"),
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Google',
                  fontWeight: FontWeight.normal),
            )
                : CircularProgress();
          }),
        ],
      ),
    );
  }
}
