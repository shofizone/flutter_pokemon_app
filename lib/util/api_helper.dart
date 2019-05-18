import 'package:pokemon_app/models/poke_hub.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class ApiHelper{
  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<PokeHub> fetchData() async{
    var response =  await http.get(url);
    var jsonData = jsonDecode(response.body);

    PokeHub pokeHub =  PokeHub.fromJson(jsonData);
    return pokeHub;
  }


}