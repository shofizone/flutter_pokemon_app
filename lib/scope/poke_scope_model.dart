import 'package:pokemon_app/models/poke_hub.dart';
import 'package:pokemon_app/util/api_helper.dart';
import 'package:pokemon_app/util/search_helper.dart';
import 'package:scoped_model/scoped_model.dart';


class PokeScopeModel extends Model{
  PokeHub _pokeHub;
  bool _isListView = false;
  ApiHelper apiHelper = ApiHelper();

  PokeScopeModel(){
    getData();
  }

  bool get isListView => _isListView;

  set isListView(bool value) {
    _isListView = value;
    notifyListeners();
  }


  get pokeHub => _pokeHub;

  set pokeHub(PokeHub p) => _pokeHub = p;

  getData(){
    apiHelper.fetchData().then((data) {

      pokeHub = data;
      searchHelper.pokemons =data.pokemon;
      notifyListeners();
    });
  }

}