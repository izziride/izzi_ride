
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/instanse.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';

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

class SearchCitySearch extends StatefulWidget {
  final String initialCity;
  final Function(String,String,double,double,int) update;
  const SearchCitySearch({required this.initialCity, required this.update, super.key});

  

  @override
  State<SearchCitySearch> createState() => _SearchCitySearch();
}

class _SearchCitySearch extends State<SearchCitySearch> {
  int _availableCityIndex=-1;
  void goToMap(BuildContext context,String placeId,String description,int index)async {

    setState(() {
      _availableCityIndex=index;
    });
    PlacesDetailsResponse details = await places.getDetailsByPlaceId(placeId);
    if(details.errorMessage!=""){
      setState(() {
      _availableCityIndex=-1;
    });
    }
  List<AddressComponent> addressComponents=details.result.addressComponents;
  
  inspect(addressComponents);
  String city="";
  String state="";
  String stateShort="";
  String country="";
  String street="";
  String homeNumber="";
  addressComponents.forEach((element) {
    List<dynamic> elementInfo=element.types;
    elementInfo.forEach((info) {
      if((info=="locality"|| info=="administrative_area_level_3")&&city.isEmpty){
          city=element.longName;
      }
      if(info=="street_number"){
          homeNumber=element.longName;
      }
      if(info=="route"){
          street=element.longName;
      }
      if(info=="country"){
          country=element.longName;
      }
      if(info=="administrative_area_level_1"){
          state=element.longName;
          stateShort=element.shortName;
      }
      });
    });
     if(city==""){
      city=state;
     }
     double lat=details.result.geometry?.location.lat??0;
     double lng=details.result.geometry?.location.lng??0;
     bool? perm=await HttpUser().getPermission("location");
          if(perm!=null&&!perm){
            
            return;
          }
         if(perm==null){
           
          return;
         }
        print("steeep");
        print("$state,$city,$lat,$lng");
        final intr=Dio();
        intr.interceptors.add(AuthInterceptor(intr));
      final result= await intr.get(
        "http://31.184.254.86:9099/api/v1/city",
        queryParameters: {
          "state":state,
          "city":city,
          "latityde":lat,
          "longitude":lng
        }
        
        );
        print(result.data);
        int cityId=result.data["data"]["city_id"];
        widget.update(city,state,lat,lng,cityId);

      textFocus.unfocus();
      Navigator.pop(context);
    setState(() {
      _availableCityIndex=-1;
    });
  }

  final places = GoogleMapsPlaces(apiKey: 'AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY');
  List<Prediction> _cityList=[];
  FocusNode textFocus = FocusNode();
  TextEditingController localController = TextEditingController();
  bool focus = false;
   void onTextChanged(String text) async{
        if (text.isNotEmpty) {
        bool? perm=await HttpUser().getPermission("location");
          if(perm!=null&&!perm){
            
            return;
          }
         if(perm==null){
          
          return;
         }
         print("place");
         PlacesAutocompleteResponse response = await places.autocomplete(
    text,
    language: "us", 
    types: ["postal_code","sublocality","administrative_area_level_3","locality","street_address"],
    components: [Component(Component.country, "us")], 
  );
  print(response);
  setState(() {
      _cityList=response.predictions;
    });
          
          inspect(response);
          
        } else {
          setState(() {
            _cityList = [];
          });
        }
        
      
    }
  @override
  void initState() {
    
    localController.text = widget.initialCity;
    onTextChanged(widget.initialCity);
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

  @override
  Widget build(BuildContext context) {
    ArgumentSetting arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentSetting;
   print(widget.initialCity);


 
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        BarNavigation(back: true, title: "Road "+arguments.hint),
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
                  ? arguments.hint=="from"? SizedBox(
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
                          )):Container()
                      : SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                          child: SizedBox(
                              height: 55.0*_cityList.length+8,
                              child: ListView.builder(
                                itemCount: _cityList.length,
                                
                                itemBuilder: (context, index) {
                                  List<String> _description= _cityList[index].description!.split(",");

                                  return Padding(
                                    padding: const EdgeInsets.only(top:12),
                                    child: InkWell(
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
                                                     EdgeInsets.only(
                                                        right: _availableCityIndex==index?9:0),
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
                                                    "assets/svg/chevron-left.svg",
                                                                                                 ),
                                              )
                                            ],
                                          )),
                                    ),
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
