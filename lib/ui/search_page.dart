import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/models/poke_hub.dart';
import 'package:pokemon_app/ui/poke_details.dart';
import 'package:pokemon_app/util/search_helper.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.white.withOpacity(0.6), width: 1.5)),
                  ),
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: searchHelper.changeQuery,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Search",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<Pokemon>>(
          stream: searchHelper.items,
          builder: (context, AsyncSnapshot<List<Pokemon>> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index)  {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      onTap: ()=> Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PokeDetails(
                                pokemon: snapshot.data[index],
                              ))),
                      leading:Container(
                        decoration: BoxDecoration(
                          color: Color(0xffE5EFF1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: snapshot.data[index].img,
                            child: FadeInImage(
                                width: 55,
                                height: 55,
                                fit: BoxFit.fill,
                                placeholder: AssetImage("images/loader.gif"),
                                image: CachedNetworkImageProvider(
                                    snapshot.data[index].img)),
                          ),
                        ),
                      ),
                      title: Text(snapshot.data[index].name.toString()),
                      subtitle: Text("Weight: ${snapshot.data[index].weight.toString()}"),
                    ),
                  );

                },);

            }else return Container();
          }
      ),
    );
  }
}
