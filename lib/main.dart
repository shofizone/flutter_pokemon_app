import 'package:flutter/material.dart';
import 'package:pokemon_app/scope/poke_scope_model.dart';
import 'package:pokemon_app/ui/home_page.dart';
import 'package:pokemon_app/scope/poke_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  PokeScopeModel pokeScopeModel = PokeScopeModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon Apps',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ScopedModel<PokeScopeModel>(
          model: pokeScopeModel,
          child: MyHomePage()),
    );
  }
}

