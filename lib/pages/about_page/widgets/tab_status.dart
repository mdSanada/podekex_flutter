import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:podekex_flutter/circular_progress/circular_progress.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/models/pokeapiv2.dart';
import 'package:podekex_flutter/models/specie.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:podekex_flutter/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

class StatusTab extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();

  List<int> getPokemonStatus(PokeApiV2 pokeApiV2) {
    List<int> _list = [0, 1, 2, 3, 4, 5, 6];
    int sum = 0;
    pokeApiV2.stats.forEach(
        (element) {
          sum = sum + element.baseStat;
          switch (element.stat.name) {
          case 'speed':
            _list[0] = element.baseStat;
            break;
          case 'special-defense':
            _list[1] = element.baseStat;
            break;
          case 'special-attack':
            _list[2] = element.baseStat;
            break;
          case 'defense':
            _list[3] = element.baseStat;
            break;
          case 'attack':
            _list[4] = element.baseStat;
            break;
          case 'hp':
            _list[5] = element.baseStat;
            break;
          default:
            break;
        }
      },
    );
    _list[6] = sum;
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (context) {
        Specie _specie = _pokeApiV2Store.specie;
        PokeApiV2 _pokeApiV2 = _pokeApiV2Store.pokeApiV2;
        Pokemon _currentPokemon = _pokeApiStore.currentPokemon;
        List<int> _listStatus = getPokemonStatus(_pokeApiV2Store.pokeApiV2);
        return _specie != null && _currentPokemon != null && _pokeApiV2 != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Speed',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Sp. Defense',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Sp. Attack',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Defense',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Attack',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HP',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontFamily: 'Google',
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          _listStatus[0].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[1].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[2].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[3].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[4].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[5].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _listStatus[6].toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          StatusBar(
                            widhtFactor: (_listStatus[0] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[1] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[2] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[3] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[4] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[5] / 160).toDouble(),
                          ),
                          SizedBox(height: 10),
                          StatusBar(
                            widhtFactor: (_listStatus[6] / 680).toDouble(),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : CircularProgress();
      }),
    );
  }
}

class StatusBar extends StatelessWidget {
  final double widhtFactor;
  const StatusBar({Key key, this.widhtFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      child: Center(
        child: Container(
          height: 4,
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            widthFactor: widhtFactor,
            heightFactor: 1.0,
            child: Observer(builder: (context) {
              Color statusColor = Colors.green;
              if (widhtFactor <= 0.35) {
                statusColor = Colors.red;
              } else if (widhtFactor > 0.35 && widhtFactor <= 0.6) {
                statusColor = Colors.orangeAccent;
              }
              return Container(
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: statusColor,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
