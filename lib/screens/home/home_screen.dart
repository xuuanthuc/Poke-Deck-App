import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/screens/details/detail_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0,
        title: Text("Poke Deck"),
        backgroundColor: Colors.greenAccent,
      ),
      body: pokeHub == null? Center(child: CircularProgressIndicator(),):GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPoke(
                                        pokemon: poke,
                                      )));
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: FadeInImage(
                                    placeholder: AssetImage('assets/images/poke.png'),
                                    image: NetworkImage(poke.img),
                                    // Container(
                                    //   height: 100,
                                    //   width: 100,
                                    //   decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //       image: NetworkImage(poke.img),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: poke.type
                                      .map((type) => FilterChip(
                                          backgroundColor: Colors.amberAccent,
                                          label: Text(
                                            type,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                          onSelected: (b) {}))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.greenAccent,
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
