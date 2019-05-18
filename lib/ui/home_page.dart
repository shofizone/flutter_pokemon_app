import 'package:flutter/material.dart';
import 'package:pokemon_app/models/poke_hub.dart';
import 'package:pokemon_app/scope/poke_scope_model.dart';
import 'package:pokemon_app/ui/poke_details.dart';
import 'package:pokemon_app/ui/search_page.dart';
import 'package:pokemon_app/util/api_helper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokémon"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SearchPage()));},
            ),
          ],
        ),
        body: ScopedModelDescendant<PokeScopeModel>(
          builder: (BuildContext context, Widget child, model) {
            if (model.pokeHub != null) {
              Color activeColor = Colors.green;
              Color inactiveColor = Colors.grey;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.list,
                            size: 30,
                          ),
                          onPressed: () {
                            model.isListView = true;
                          },
                          color: model.isListView ? activeColor : inactiveColor,
                        ),
                        IconButton(
                          icon: Icon(Icons.grid_on),
                          onPressed: () {
                            model.isListView = false;
                          },
                          color: model.isListView ? inactiveColor : activeColor,
                        ),
                      ],
                    ),
                    model.isListView
                        ? _buildListView(model.pokeHub)
                        : _buIldGridView(model.pokeHub),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget _buildListView(PokeHub pokeHub) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: pokeHub.pokemon.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PokeDetails(
                          pokemon: pokeHub.pokemon[index],
                        )));
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xffE5EFF1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: pokeHub.pokemon[index].img,
                    child: FadeInImage(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        placeholder: AssetImage("images/loader.gif"),
                        image: CachedNetworkImageProvider(
                            pokeHub.pokemon[index].img)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  pokeHub.pokemon[index].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buIldGridView(PokeHub pokeHub) {
    return GridView.count(
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: pokeHub.pokemon
            .map((Pokemon poke) => Padding(
                padding: EdgeInsets.all(2.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PokeDetails(
                                    pokemon: poke,
                                  )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                          tag: poke.img,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffE5EFF1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage("images/loader.gif"),
                                  image: CachedNetworkImageProvider(poke.img)),
                            ),
                          ),
                        ),
                        Text(
                          poke.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
                )))
            .toList());
  }
}
