import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:podekex_flutter/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AboutPage extends StatefulWidget {

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: Observer(
          builder: (context) {
            return AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: TabBar(
                controller: _tabController,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: _pokemonStore.pokemonColor,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true,
                indicator: MD2Indicator(
                    indicatorHeight: 3,
                    indicatorColor: _pokemonStore.pokemonColor,
                    indicatorSize: MD2IndicatorSize.normal
                ),
                tabs: <Widget>[
                  Tab(
                    text: "Sobre",
                  ),
                  Tab(
                    text: "Evolução",
                  ),
                  Tab(
                    text: "Status",
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
