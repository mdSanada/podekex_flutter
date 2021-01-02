import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/models/pokeapi.dart';
import 'package:podekex_flutter/pages/about_page/about_page.dart';
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
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.4);
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
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _pokemonStore.pokemonColor.withOpacity(0.7),
                      _pokemonStore.pokemonColor
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
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
                                      opacity: _opacityTitleAppBar >= 0.2
                                          ? 0.2
                                          : 0.0,
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
                    ),
                    Positioned(
                      child: Text(
                        _pokemonStore.currentPokemon.name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 38 -
                                _progress *
                                    (MediaQuery.of(context).size.height * 0.015),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      top: MediaQuery.of(context).size.height * 0.12 -
                          _progress *
                              (MediaQuery.of(context).size.height * 0.070),
                      left: 20 +
                          _progress *
                              (MediaQuery.of(context).size.height * 0.05),
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.height * 0.16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 22),
                          child: Row(
                            children: [
                              setDetailedTipos(
                                  _pokemonStore.currentPokemon.type),
                              Text(
                                '#' +
                                    _pokemonStore.currentPokemon.num.toString(),
                                style: TextStyle(
                                    fontFamily: 'Google',
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
              );
            },
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
              snappings: [0.6, 0.88],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.88,
                child: AboutPage(),
              );
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1
                      ? 1000
                      : (MediaQuery.of(context).size.height * 0.25) -
                          (_progress * 50)),
              child: SizedBox(
                  height: 150,
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
                                        height: 200,
                                        width: 200,
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
                                          : 35),
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

Widget setDetailedTipos(List<String> types) {
  List<Widget> lista = [];
  types.forEach((nome) {
    lista.add(
      Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(80, 255, 255, 255)),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                nome.trim(),
                style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  });
  return Row(
    children: lista,
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}
