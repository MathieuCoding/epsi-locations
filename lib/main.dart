import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/models/type_habitat.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mes locations'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({required this.title, Key? key}) : super(key: key);

  final _typehabitats = [
    TypeHabitat(1, "Maison"),
    TypeHabitat(2, "Appartement")
  ];
  final _habitations = [
    Habitation(1, "maison.png", "Maison méditerranéenne",
        "12 Rue du Coq qui chante", 3, 92, 600),
    Habitation(
        2, "appartement.png", "Appartement neuf", "Rue de la soif", 1, 50, 555),
    Habitation(3, "appartement.png", "Appartement 1", "Rue 1", 1, 51, 401),
    Habitation(4, "appartement.png", "Appartement 2", "Rue 2", 1, 52, 402),
    Habitation(5, "maison.png", "Maison 1", "Rue M1", 3, 101, 701),
    Habitation(6, "maison.png", "Maison 2", "Rue M2", 3, 102, 702),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(),
            SizedBox(height: 20),
            _buildDerniereLocation(context),
          ],
        ),
      ),
    );
  }

  _buildTypeHabitat() {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _typehabitats.length,
          (index) => _buildHabitat(_typehabitats[index]),
        ),
      ),
    );
  }

  _buildHabitat(TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1: House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white70,
            ),
            SizedBox(width: 5),
            Text(
              typeHabitat.libelle,
              style: LocationTextStyle.regularWhiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        itemCount: _habitations.length,
        itemExtent: 220,
        itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return Container(
      width: 240,
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            habitation.libelle,
            style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text(
                habitation.adresse,
                style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
            format.format(habitation.prixmois),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
    );
  }
}