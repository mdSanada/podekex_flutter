import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_api.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;

  Color _corPokemon;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.currentPokemon;
    _corPokemon = ConstsAPI.getColorType(type: _pokemon.type.first);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer (
          builder: (BuildContext context) {
            _corPokemon = ConstsAPI.getColorType(type: _pokemonStore.currentPokemon.type.first);
            return AppBar(
              title: Opacity(
                opacity: 0,
                child: Text(
                  _pokemon.name,
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: _corPokemon,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              _corPokemon = ConstsAPI.getColorType(type: _pokemonStore.currentPokemon.type.first);
              return Container(
                color: _corPokemon,
              );
            },
          ),
          Container(
            height: (MediaQuery.of(context).size.height / 3),
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: SizedBox(
                height: 150,
                child: PageView.builder(
                    onPageChanged: (index) {
                      _pokemonStore.setCurrentPokemon(index: index);
                    },
                    itemCount: _pokemonStore.pokeAPI.pokemon.length,
                    itemBuilder: (BuildContext context, int count) {
                      Pokemon _pokeitem =
                          _pokemonStore.getPokemon(index: count);
                      return _pokemonStore.getImageWithSize(
                          numero: _pokeitem.num, size: 60);
                    })),
          )
        ],
      ),
    );
  }
}
