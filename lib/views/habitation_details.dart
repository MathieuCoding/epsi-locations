import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/resa_location.dart';
import 'package:location/views/share/bottom_navigation_bar_widget.dart';
import 'package:location/views/share/custom_app_bar.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {super.key});

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleContent: widget._habitation.libelle),
      bottomNavigationBar: BottomNavigationBarWidget(2),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          SizedBox(
            height: 8.0,
          ),
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomDivider(name: 'Inclus'),
                _buildItems(),
                CustomDivider(name: 'Options'),
                _buildOptionsPayantes(),
              ],
            ),
          ),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResaLocation(widget._habitation)),
                );
              },
              child: Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }

  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;
    return Wrap(
      children: Iterable.generate(
        widget._habitation.options.length,
        (i) => Container(
          width: width,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.options[i].libelle),
              Text(
                widget._habitation.options[i].description,
                style: LocationTextStyle.regularGreyTextStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;
    return Wrap(
      children: Iterable.generate(
        widget._habitation.optionspayantes.length,
        (i) => Container(
          width: width,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.optionspayantes[i].libelle),
              Text(
                widget._habitation.optionspayantes[i].prix.toString(),
                style: LocationTextStyle.regularGreyTextStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Text(
            name,
            style: LocationTextStyle.subtitleBoldTextStyle,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
