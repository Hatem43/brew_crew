// this will be for outputting different brews on the page

import 'package:flutter/material.dart';
import 'package:brew_crew/modules/brew.dart';
import 'package:provider/provider.dart';
import "package:brew_crew/screens/home/brew_tile.dart";

class brewList extends StatefulWidget {
  @override
  _brewListState createState() => _brewListState();
}

class _brewListState extends State<brewList> {
  @override
  Widget build(BuildContext context) {
    final brews=Provider.of<List<Brew>>(context) ?? []; // this for accessing Brews list that we are recording from
    return ListView.builder(
        itemCount:brews.length,
        itemBuilder: (context,i){
          return BrewTile(brew:brews[i]); //this will pass through all different brews
        },
    );
  }
}
