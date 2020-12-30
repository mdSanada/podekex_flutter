import 'package:flutter/material.dart';
import 'package:podekex_flutter/consts/consts_api.dart';
import 'package:podekex_flutter/consts/consts_app.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Opacity(
                    child: Image.asset(
                      ConstsApp.whitePokeball,
                      height: 80,
                      width: 80,
                    ),
                    opacity: 0.2,
                  ),
                  Align(
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                    ),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstsAPI.getColorType(type: types.first),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
