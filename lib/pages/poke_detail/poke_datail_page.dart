import 'package:flutter/material.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.currentPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
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
              backgroundColor: _pokemonStore.pokemonColor,
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
              return Container(
                color: _pokemonStore.pokemonColor,
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
                    controller: _pageController,
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
