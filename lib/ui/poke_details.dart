import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/models/poke_hub.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetails({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 86),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),

                  Text(pokemon.name, style:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text(
                    "Height: ${pokemon.height}",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.brightness_1,color:  Color(0xffE5EFF1),),
                  ),
                  Text("Weight: ${pokemon.weight}",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                ],),
                  SizedBox(height: 8,),
                  Text("Types",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) => FilterChip(
                              label: Text(t,style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                              backgroundColor: Colors.amber,
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 8,),
                  Text("Weakness",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      crossAxisCount: 4,
                      childAspectRatio: 1.5,
                      children: pokemon.weaknesses
                          .map((t) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(
                          child: Text(
                            t, style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),),
                        ),),)
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 16,),
                  pokemon.nextEvolution == null? Container(): Column(
                   children: <Widget>[
                     Text("Next Evolution",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                     SizedBox(height: 8,),
                     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: pokemon.nextEvolution
                           .map((t) => FilterChip(
                         label: Text(t.name,style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                         backgroundColor: Colors.amber,
                         onSelected: (b) {},
                       ))
                           .toList(),
                     ),
                   ],
                 ),
                  pokemon.prevEvolution == null? Container(): Column(
                    children: <Widget>[
                      Text("Next Evolution",style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.prevEvolution
                            .map((t) => FilterChip(
                          label: Text(t.name,style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                          backgroundColor: Colors.amber,
                          onSelected: (b) {},
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffE5EFF1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Hero(
                  tag: pokemon.img,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: AssetImage("images/loader.gif"),
                          image: CachedNetworkImageProvider(
                              pokemon.img)),
                    ),
                  )),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        title: Text(pokemon.name),
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          bodyWidget(context)
        ],
      ),
    );
  }
}
