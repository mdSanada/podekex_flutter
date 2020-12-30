import 'package:flutter/material.dart';
import 'package:podekex_flutter/pages/home_page/home_page.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex - FLutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
      providers: <SingleChildWidget>[
        Provider<PokeApiStore>(
          create: (_) => PokeApiStore(),
        )
      ],
    );
  }
}
