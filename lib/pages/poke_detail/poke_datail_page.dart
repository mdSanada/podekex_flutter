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
    Pokemon _pokemon = _pokemonStore.getPokemon(index: index);
    _corPokemon = ConstsAPI.getColorType(type: _pokemon.type.first);
    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
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
          ),
          backgroundColor: _corPokemon,
          body: Stack(
            children: <Widget>[
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
                        itemCount: _pokemonStore.pokeAPI.pokemon.length,
                        itemBuilder: (BuildContext context, int count) {
                          Pokemon _pokeitem = _pokemonStore.getPokemon(index: count);
                          return _pokemonStore.getImageWithSize(
                              numero: _pokeitem.num, size: 60);
                        })),
              )
            ],
          ),
        );
      },
    );
  }
}
