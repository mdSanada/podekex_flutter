import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:podekex_flutter/consts/consts_api.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon _currentPokemon;

  @observable
  Color pokemonColor;

  @observable
  int currentPosition;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  Pokemon get currentPokemon => _currentPokemon;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  Pokemon getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setCurrentPokemon({int index}) {
    _currentPokemon = _pokeAPI.pokemon[index];
    pokemonColor = ConstsApp.getColorType(type: _currentPokemon.type.first);
    currentPosition = index;
  }

  @action
  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  @action
  Widget getImageWithSize({String numero, double size}) {
    return CachedNetworkImage(
      height: size,
      width: size,
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  @action
  Widget getImageWithSizeAnimation({String numero, double size, int index, int current}) {
    return CachedNetworkImage(
      height: size,
      width: size,
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      color: index == current ? null : Colors.black.withOpacity(0.5),
      imageUrl:
      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
