import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_api.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';

class PokeItem extends StatefulWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  @override
  _PokeItemState createState() => _PokeItemState();
}

class _PokeItemState extends State<PokeItem> {
  PokeApiStore _pokemonStore;

  Widget setTipos() {
    List<Widget> lista = [];
    widget.types.forEach((nome) {
      lista.add(
        Column(
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
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  void initState() {
    super.initState();
    _pokemonStore = GetIt.instance<PokeApiStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Align(
                child: Hero(tag: widget.name,child: _pokemonStore.getImageWithSize(numero: widget.num, size: 80)),
                alignment: Alignment.bottomRight,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Google',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: setTipos(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Hero(
                      tag: widget.name + 'rotation',
                      child: Opacity(
                        child: Image.asset(
                          ConstsApp.whitePokeball,
                          height: 80,
                          width: 80,
                        ),
                        opacity: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstsAPI.getColorType(type: widget.types.first),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
