
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/pages/main/tabs/create/map/map_search.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:geolocator/geolocator.dart';

class ArgumentSetting {
  SvgPicture icon;
  String hint;
  ArgumentSetting(this.icon, this.hint);
}

class MapPage {
  String longitude;
  String latitude;
  String city;
  MapPage(this.longitude, this.latitude, this.city);
}

class SearchFrom extends StatefulWidget {
  final String city;
  final Function(String,String,double,double)  update;
  const SearchFrom({required this.city, required this.update, super.key});

  

  @override
  State<SearchFrom> createState() => _SearchFromState();
}

class _SearchFromState extends State<SearchFrom> {
  int _availableCityIndex=-1;
  void goToMap(BuildContext context,String placeId,String description,int index)async {

    setState(() {
      _availableCityIndex=index;
    });
    bool? perm=await HttpUser().getPermission("location");
          if(perm!=null&&!perm){
            return;
          }
         if(perm==null){
          return;
         }
    PlacesDetailsResponse details = await places.getDetailsByPlaceId(placeId);
    if(details.errorMessage!=""){
      setState(() {
      _availableCityIndex=-1;
    });
    }
    inspect(details);
    MapPage params = MapPage(details.result.geometry!.location.lng.toString(), details.result.geometry!.location.lat.toString(), description,);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSearch(update: widget.update,placeId:placeId),
        settings: RouteSettings(arguments: params),
      ),
    );
    setState(() {
      _availableCityIndex=-1;
    });
  }

  final places = GoogleMapsPlaces(apiKey: 'AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY');
  List<Prediction> _cityList=[];
  FocusNode textFocus = FocusNode();
  TextEditingController localController = TextEditingController();
  bool focus = false;

  @override
  void initState() {

    localController.text = widget.city;
    onTextChanged(localController.text);
    textFocus.requestFocus();
    textFocus.addListener(() {
      if (textFocus.hasFocus) {
        setState(() {
          focus = true;
        });
      } else {
        setState(() {
          focus = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    localController.dispose();
    super.dispose();
  }
 void onTextChanged(String text) async{
        if (text.isNotEmpty) {
          bool? perm=await HttpUser().getPermission("location");
          if(perm!=null&&!perm){
            return;
          }
         if(perm==null){
          return;
         }
          PlacesAutocompleteResponse response = await places.autocomplete(
    text,
    language: "us", 
    types: ["postal_code","sublocality","administrative_area_level_3","locality","street_address"],
    components: [Component(Component.country, "us")], 
  );
  inspect(response);
    setState(() {
      _cityList=response.predictions;
    });
          
          
          
        } else {
          setState(() {
            _cityList = [];
          });
        }
        
      
    }
  @override
  Widget build(BuildContext context) {
    ArgumentSetting arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentSetting;
   


   

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          toolbarOpacity: 0,
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
        BarNavigation(back: true, title: "${arguments.hint}"),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: categorySelected,
                    borderRadius: BorderRadius.circular(10)),
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 9),
                      child: arguments.icon,
                    ),
                    Expanded(
                      child: TextField(
                        controller: localController,
                        focusNode: textFocus,
                        textInputAction: TextInputAction.done,
                        onChanged: onTextChanged,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                            hintText: arguments.hint,
                            border: InputBorder.none,
                            counterText: ""),
                      ),
                    ),
                  ],
                ),
              ),
              focus
                  ?localController.text.isEmpty
                  ? arguments.hint=="from"? InkWell(
                    onTap: ()async {
                       bool serviceEnabled;
                        LocationPermission permission;

                        
                        serviceEnabled = await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                         
                          return Future.error('Location services are disabled.');
                        }

                        permission = await Geolocator.checkPermission();
                         if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {
                              // Permissions are denied, next time you could try
                              // requesting permissions again (this is also where
                              // Android's shouldShowRequestPermissionRationale 
                              // returned true. According to Android guidelines
                              // your App should show an explanatory UI now.
                              return Future.error('Location permissions are denied');
                            }
                          }
                      if(permission==LocationPermission.always||permission==LocationPermission.whileInUse){
                            Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high,
                        );
                           MapPage params = MapPage(position.longitude.toString(), position.latitude.toString(), "mock",);

                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapSearch(update: widget.update,placeId:"mock"),
                            settings: RouteSettings(arguments: params),
                          ),
                        );
                      }
                      
                    },
                    child: SizedBox(
                            height: 44,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 10),
                                  child:
                                      SvgPicture.asset("assets/svg/geo.svg"),
                                ),
                                const Text("Use my geolocation"),
                              ],
                            )),
                  ):Container()
                      : SingleChildScrollView(
                          child: SizedBox(
                              height: 215,
                              child: ListView.builder(
                                itemCount: _cityList.length,
                                
                                itemBuilder: (context, index) {
                                  List<String> _description= _cityList[index].description!.split(",");

                                  return InkWell(
                                    onTap: () {
                                      if(_availableCityIndex==-1){
                                        goToMap(
                                          context,      
                                          _cityList[index].placeId!,
                                          _cityList[index].description!,
                                          index
                                          );
                                      }
                                      
                                          
                                    },
                                    child: SizedBox(
                                        height: 43,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _description[0],
                                                  style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          51, 51, 51, 1)),
                                                ),
                                                Text(
                                                  "${_description[2]}, ${_description[1]}",
                                                  style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          119,
                                                          119,
                                                          119,
                                                          1)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      right: 4),
                                              child:_availableCityIndex==index
                                              ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.green,
                                                  
                                                ),
                                              ) 
                                              :SvgPicture.asset(
                                                  "assets/svg/upToMap.svg"),
                                            )
                                          ],
                                        )),
                                  );
                                },
                              )),
                        ):Container()
            ],
          ),
        )
          ],
        ));
  }
}
