import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/pages/home_page/widgets/app_bar_home.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;
  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.6),
            child: Opacity(
                child: Image.asset(
                  ConstsApp.blackPokeball,
                  height: 240,
                  width: 240,
                ),
                opacity: 0.1),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusBarHeight,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(child: Container(
                    child: Observer(
                      builder: (BuildContext context) {
                        PokeAPI _pokeApi = pokeApiStore.pokeAPI;
                        return (pokeApiStore.pokeAPI != null) ?
                          ListView.builder(
                            itemCount: _pokeApi.pokemon.length,
                            itemBuilder: (context, index) {
                              return ListTile(title: Text(_pokeApi.pokemon[index].name),);
                            },
                          )
                        : Center(child: CircularProgressIndicator(),);
                      },
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
