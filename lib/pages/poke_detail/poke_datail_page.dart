import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_animations/simple_animations.dart';

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
  MultiTrackTween _animation;
  double _progress;
  double _multiplier;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.currentPokemon;
    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 6), Tween(begin: 0.0, end: 6),
          curve: Curves.linear)
    ]);
    _progress = 0;
    _multiplier = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
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
                opacity: _opacityTitleAppBar,
                child: Observer (
                  builder: (BuildContext context) {
                    return Text(
                      _pokemonStore.currentPokemon.name,
                      style: TextStyle(
                        fontFamily: 'Google',
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    );
                  },
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ControlledAnimation(
                        playback: Playback.LOOP,
                        duration: _animation.duration,
                        tween: _animation,
                        builder: (context, animation) {
                          return Transform.rotate(
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              child: Image.asset(
                                ConstsApp.whitePokeball,
                                height: 50,
                                width: 50,
                              ),
                              opacity: _opacityTitleAppBar >= 0.2 ? 0.2 : 0.0,
                            ),
                            angle: animation['rotation'],
                          );
                        }),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ],
                )
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
            cornerRadius: 30,
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiplier = 1 - interval(0.60, 0.87, _progress);
                _opacity = _multiplier;
                _opacityTitleAppBar = interval(0.60, 0.87, _progress);
              });
            },
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
          Opacity(
            opacity: _opacity,
            child: Padding(
              padding: EdgeInsets.only(top: _opacityTitleAppBar == 1 ? 1000 : 60 - (_progress * 50)),
              child: SizedBox(
                  height: 200,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _pokemonStore.setCurrentPokemon(index: index);
                      },
                      itemCount: _pokemonStore.pokeAPI.pokemon.length,
                      itemBuilder: (BuildContext context, int index) {
                        Pokemon _pokeitem =
                            _pokemonStore.getPokemon(index: index);
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ControlledAnimation(
                              playback: Playback.LOOP,
                              duration: _animation.duration,
                              tween: _animation,
                              builder: (context, animation) {
                                return Transform.rotate(
                                  angle: animation['rotation'],
                                  child: Hero(
                                    tag: _pokeitem.name + 'rotation',
                                    child: Opacity(
                                      child: Image.asset(
                                        ConstsApp.whitePokeball,
                                        height: 270,
                                        width: 270,
                                      ),
                                      opacity: 0.2,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Observer(
                              builder: (context) {
                                return AnimatedPadding(
                                  child: Hero(
                                    tag: _pokeitem.name,
                                    child:
                                        _pokemonStore.getImageWithSizeAnimation(
                                            numero: _pokeitem.num,
                                            size: 160,
                                            index: index,
                                            current:
                                                _pokemonStore.currentPosition),
                                  ),
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.bounceInOut,
                                  padding: EdgeInsets.all(
                                      index == _pokemonStore.currentPosition
                                          ? 0
                                          : 60),
                                );
                              },
                            ),
                          ],
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }
}
