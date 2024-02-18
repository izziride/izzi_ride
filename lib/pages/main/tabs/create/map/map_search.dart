import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/pages/main/tabs/create/map/ui_map.dart';
import 'package:temp/pages/main/tabs/create/search_city_create/search_city_create.dart';

class MapSearch extends StatefulWidget{
  final Function(String,String,double,double)  update;
  final String placeId;
  const MapSearch({required this.placeId, required this.update, super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {

  @override
  Widget build(BuildContext context) {

    MapPage arguments =ModalRoute.of(context)!.settings.arguments as MapPage;
    inspect(arguments);
    return Scaffold(
      appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 0,
              toolbarOpacity: 0,
              elevation: 1,
              backgroundColor: Colors.white,
              
          ),
          body: Stack(
            children: [
               UIMap(
                    city:arguments.city,
                    latitude: double.parse(arguments.latitude) , 
                    longitude: double.parse(arguments.longitude),
                    update:widget.update, 
                    
                    ),
                
              
            ],
          )
    );
  }
} 