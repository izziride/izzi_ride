import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:temp/http/user/http_user.dart';

class UIMap extends StatefulWidget {
 final double latitude;
 final double longitude;
 final Function(String,String,double,double) update;
 final String city;
 const UIMap(
      {required this.city,
      required this.update,
      required this.latitude,
      required this.longitude,
      super.key});

  @override
  State<UIMap> createState() => _UIMapState();
}

class _UIMapState extends State<UIMap> {
  TextEditingController _textcontroller=TextEditingController();
  late String _positionInformation;
  String _city="";
  String _state="";
  String _stateShort="";
  String _country="";
  String _street="";
  String _homeNumber="";

    CameraPosition initial = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
          final Completer<GoogleMapController> _completer=
      Completer<GoogleMapController>();
    late GoogleMapController _controller;
  double latitudeRide = 0;
  double longitudeRide = 0;
  Set<Marker> _markers={
    
  };

  getResult(double lat,double lng)async{
    bool? perm=await HttpUser().getPermission("geocoding");
          if(perm!=null&&!perm){
            return;
          }
         if(perm==null){
          return;
         }
    final geocode = await Dio().get(
    "https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY"
  );
  //inspect(geocode);
  List<dynamic> addressComponents=geocode.data["results"][0]["address_components"];
  print(addressComponents);
  String city="";
  String state="";
  String stateShort="";
  String country="";
  String street="";
  String homeNumber="";
  addressComponents.forEach((element) {
    List<dynamic> elementInfo=element["types"];
    elementInfo.forEach((info) {
      if(info=="locality"|| info=="administrative_area_level_3"){
          city=element["long_name"];
      }
      if(info=="street_number"){
          homeNumber=element["long_name"];
      }
      if(info=="route"){
          street=element["long_name"];
      }
      if(info=="country"){
          country=element["long_name"];
      }
      if(info=="administrative_area_level_1"){
          state=element["long_name"];
          stateShort=element["short_name"];
      }
    });
    if(city.isEmpty){
      city=state;
    }
    setState(() {
      _city=city;
      _homeNumber=homeNumber;
      _street=street;
      _country=country;
      _state=state;
      _stateShort=stateShort;
    });
  });
  print(_city);
  print(_state);
  //List<String> info=geocode.data["results"][0]["formatted_address"];
  setState(() {
    _positionInformation=geocode.data["results"][0]["formatted_address"];
  });
  //inspect(details.result.addressComponents);
  }
  




  @override
  void initState() {
    _positionInformation=widget.city;
    initial = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 18);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        
        GoogleMap(
          markers:_markers ,
          myLocationButtonEnabled: false,
          initialCameraPosition: initial,
          // onTap: (argument) {
          //   setState(() {
          //     _markers=_markers.map((el) =>Marker(
          //       markerId: MarkerId("0"),
          //       position: LatLng(argument.latitude, argument.longitude)
          //       )).toSet();
          //   });
          //   getResult(argument.latitude,argument.longitude);
          // },
          mapType: MapType.normal,
          onMapCreated: (controller) async {
            _completer.complete(controller);
            _controller=await _completer.future;
          },
          onCameraMove: (position)async {
            //final bounds = await _controller.getLatLng(const ScreenCoordinate(x: 0, y: 0));
            LatLng center=position.target;
            setState(() {
              latitudeRide = center.latitude;
              longitudeRide = center.longitude;
            });
          },
          onCameraIdle: () async {
            
            getResult(latitudeRide,longitudeRide);
           
          },

        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 200, 203, 207),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.5,right: 15.5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/svg/back.svg",
                              width: 5,
                              height: 10,
                              // ignore: deprecated_member_use
                              color: const Color.fromRGBO(58,121,215,1),
                            ),
                          ),
                        ),
                        Text(
                          "$_homeNumber ${_street.isNotEmpty?_street+",":""} ${_city.isNotEmpty?_city+",":""} ${_stateShort.isNotEmpty?_stateShort+",":""} $_country",
                          style: const TextStyle(
                            color: Color.fromRGBO(87,87,88,1),
                            fontFamily: "Inter",
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                          ),
                          )
                      ],
                    ),
                  ),
                ),
        ),
        SvgPicture.asset("assets/svg/marker.svg"),
        Positioned(
          bottom: 42,
          right: 27,
          child: InkWell(
            onTap: () {
              String fullAdress= "$_homeNumber ${_street.isNotEmpty?_street+",":""} ${_city.isNotEmpty?_city+",":""} ${_stateShort.isNotEmpty?_stateShort+",":""} $_country";
              //DataCreate newDate =DataCreate(_city,_state, latitudeRide, longitudeRide,fullAdress);
              widget.update(_city,_state, latitudeRide, longitudeRide);
             // widget.update(newDate);
              Navigator.pop(context);
              Navigator.pop(context);
              
            },
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color.fromRGBO(58, 121, 215, 1)),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
