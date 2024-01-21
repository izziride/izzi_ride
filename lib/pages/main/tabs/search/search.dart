

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp/pages/main/tabs/search/UI/calendare/calendare.dart';
import 'package:temp/pages/main/tabs/search/UI/card_coordinates.dart';
import 'package:temp/pages/main/tabs/search/result_search/result_search.dart';
import 'package:temp/repository/search_repo/search_repo.dart';
import 'UI/person_count/person_count.dart';


class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}



class _SearchState extends State<Search> {

  DateTime date=DateTime.now();
    void setDate(DateTime newDate){
      print(newDate.toString());
      setState(() {
        date=newDate;
         searchRepo.date=date;
      });
    }

    int personCount=1;
    
        void setPersonCount(int newValue){
          
      setState(() {
        personCount=newValue;
      });
    }


bool isFromEmpty=false;
bool isToEmpty=false;

void search(){
    if(searchRepo.fromCity.isEmpty){
      print("f");
      setState(() {
        isFromEmpty=true;
      });
    }
    if(searchRepo.toCity.isEmpty){
      print("t");
      setState(() {
        isToEmpty=true;
      });
    }
    if(!isFromEmpty&&!isToEmpty){
     
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_)=>const ResultSearch()
        )
        );
    }
}

  @override
  Widget build(BuildContext context) {

  
    
  
   return Column(
     children: [
       Padding(
         padding: const EdgeInsets.only(top:24,left: 15,right: 15),
         child: Image.asset("assets/image/search.png"),
       ),
       Padding(
        padding: const EdgeInsets.only(top: 32,left: 15,right: 15),
        child: Observer(
          builder: (context) {
            print("rename");
            String from=searchRepo.fromCity;
            String to=searchRepo.toCity;
            return Column(
              children: [
               CardCoordinates(
                valid:!isFromEmpty,
                icon: SvgPicture.asset(
                      "assets/svg/geoFrom.svg"
                      ),
                hint: "From",
                name: from,
                update:(String city,String state,double lat,double lng,int cityId ){
                  searchRepo.updateFromCity(city);
                  searchRepo.updateFromState(state);
                  searchRepo.updateFromLat(lat);
                  searchRepo.updateFromLng(lng);
                  searchRepo.updateFromCityId(cityId);
                },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CardCoordinates(
                    valid:!isToEmpty,
                    update: (String city,String state,double lat,double lng,int cityId ){
                                searchRepo.updateToCity(city);
                                searchRepo.updateToState(state);
                                searchRepo.updateToLat(lat);
                                searchRepo.updateToLng(lng);
                                searchRepo.updateToCityId(cityId);
                            },
                    name: to,
                    icon: SvgPicture.asset(
                        "assets/svg/geoTo.svg"
                        ),
                  hint: "To",
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 47,
                      child: Calendare(date: date,updateDate: setDate,)
                      ),
                     Expanded(
                      flex: 20,
                      child: PersonCount(count:personCount,update:setPersonCount)
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:12),
                  child: InkWell(
                    onTap: (){
                      search();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color:const Color.fromRGBO(64,123,255,1),
                        borderRadius: BorderRadius.circular(10)
                        
                      ),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
       )
     ],
   );
  }
}
