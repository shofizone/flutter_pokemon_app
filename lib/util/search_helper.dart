import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:pokemon_app/models/poke_hub.dart';

class SearchHelper {
  List<Pokemon> pokemons;

  var _searchQuery = PublishSubject<String>();
  Stream<String> get searchQuery => _searchQuery.stream;
  Function(String) get changeQuery => _searchQuery.sink.add;


  var _items = PublishSubject<List<Pokemon>>();
  Stream<List<Pokemon>> get items => _items.stream;
  Function(List<Pokemon>) get changeItems => _items.sink.add;

  SearchHelper() {
    _searchQuery.listen((query) async {
      _search(query);
    });
  }

  _search(String query) {
    List<Pokemon> p = List<Pokemon>();
    if(pokemons != null){
      for (var pokemon in pokemons) {
        if (pokemon.name.toLowerCase().contains(query.toLowerCase())) {
          p.add(pokemon);
        } else {
          changeItems(null);
        }
        changeItems(p);
      }
    }

  }

  void dispose() {
    _searchQuery.close();
    _items.close();
  }


}

SearchHelper searchHelper = SearchHelper();
