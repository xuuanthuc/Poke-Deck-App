import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';

class DetailPoke extends StatelessWidget {
  final Pokemon pokemon;

  DetailPoke({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(pokemon.name),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width-20,
            left: 10,
            top: MediaQuery.of(context).size.height*0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('Height: ${pokemon.height}'),
                  Text('Weight: ${pokemon.weight}'),
                  Text('Types', style: TextStyle(fontWeight: FontWeight.bold,),),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((type) => FilterChip(
                      backgroundColor: Colors.amberAccent,
                              label: Text(type),
                              onSelected: (b) {},
                            ))
                        .toList(),
                  ),
                  Text('Weakness', style: TextStyle(fontWeight: FontWeight.bold,),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((weaknesse) => FilterChip(
                      backgroundColor: Colors.redAccent,
                      label: Text(weaknesse, style: TextStyle(color: Colors.white),),
                      onSelected: (b) {},
                    ))
                        .toList(),
                  ),
                  // Text("Next Evolution"),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pokemon.nextEvolution
                  //       .map((nextEvolutions) => FilterChip(
                  //     backgroundColor: Colors.green,
                  //     label: Text(nextEvolutions.name, style: TextStyle(color: Colors.white),),
                  //     onSelected: (b) {},
                  //   ))
                  //       .toList(),
                  // ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: NetworkImage(pokemon.img),
                      fit: BoxFit.cover,
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
