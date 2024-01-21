

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/main/tabs/create/price/price.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/create_repo/create_repo.dart';

class DopOptions extends StatefulWidget {
  const DopOptions({required this.side,required this.createAuto, required this.preferences,required this.count,required this.carId, super.key});
  final bool createAuto;
  final int carId;
  final int count;
  final Preferences preferences;
  final Function side;

  @override
  State<DopOptions> createState() => _DopOptionsState();
}

class _DopOptionsState extends State<DopOptions> {
  //animalRide:
  late int animalRide;

  //baggage:
  late int baggage;

  //childPassanger:
  late int childPassange;

  ////////////////////////answer options
  late int count;

  //countPassanger:
  late int countPassanger;

  TextEditingController myController = TextEditingController();
  //smoking:
  late int smoking;

    @override
  void initState() {
    count=widget.count;
    countPassanger=widget.count;
    animalRide=widget.preferences.animals?1:2;
    childPassange=widget.preferences.childCarSeat?1:2;
    baggage=widget.preferences.luggage?1:2;
    smoking=widget.preferences.smoking?1:2;
    super.initState();
  }

  setCountPassanger(int value) {
    setState(() {
      countPassanger = value;
    });
  }

  setBaggage(int value) {
    setState(() {
      baggage = value;
    });
  }

  setChildPassange(int value) {
    setState(() {
      childPassange = value;
    });
  }

  setAnimalRide(int value) {
    setState(() {
      animalRide = value;
    });
  }

  setSmoking(int value) {
    setState(() {
      smoking = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        toolbarOpacity: 0,
        elevation: 1,
      ),
      body:Column(
        children: [ 
        BarNavigation(back: true, title: "Additional options"),
        Expanded(
          child:   ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Container(  
                  padding: const EdgeInsets.only( bottom: 8),  
                  child: Text(
      
                "Select the number of available seats",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
                for(int i =0;i<count;i++) pointAnswer(i+1, countPassanger, "${i+1}", setCountPassanger),
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Luggage",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, baggage, "Yes", setBaggage),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, baggage, "No", setBaggage),
  
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Baby chair",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, childPassange, "Yes", setChildPassange),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, childPassange, "No", setChildPassange),
  
              ],
  
            ),
  
            Container(
  
              padding: const EdgeInsets.only(top: 24, bottom: 8),
  
              child: Text(
  
                "Animals",
  
                style: currentTextStyle,
  
              ),
  
            ),
  
            Row(
  
              children: [
  
                pointAnswer(1, animalRide, "Yes", setAnimalRide),
  
                const SizedBox(width: 8),
  
                pointAnswer(2, animalRide, "No", setAnimalRide),
  
              ],
  
            ),
  
            Container(  
              padding: const EdgeInsets.only(top: 24, bottom: 8),  
              child: Text(  
                "Smoking",  
                style: currentTextStyle,  
              ), 
            ),
            Row(
              children: [
                pointAnswer(1, smoking, "Yes", setSmoking),
                const SizedBox(width: 8),
                pointAnswer(2, smoking, "No", setSmoking),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                "Comment on the ride",
                style: currentTextStyle,
              ),
            ),
           Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color.fromRGBO(173, 179, 188, 1)),
            ),
            child:  TextField(
                style: currentTextStyle,
                controller: myController,
                decoration: const InputDecoration(
                  
                  contentPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                  border: InputBorder.none,
                  hintText: "How will you go, do you plan stops, rules of behavior in the car, etc.",
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            
),
          ],
  
        ),
),
     Padding(
              padding: const EdgeInsets.only(bottom:32,left: 15,right: 15),
              child: InkWell(
                onTap: (){
                  bool baggage_=baggage==1?true:false;
                  bool childPassange_=childPassange==1?true:false;
                  bool animal_=animalRide==1?true:false;
                  bool smoking_=smoking==1?true:false;
                  createRepo.updateSmoking(smoking_);
                  createRepo.updateAnimals(animal_);
                  createRepo.updateChildCarSeat(childPassange_);
                  createRepo.updateLuggage(baggage_);
                  createRepo.updateNuberSeats(countPassanger);
                  createRepo.updateComment(myController.text);
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context)=> Price(
                        side:widget.side,
                        carId:widget.carId,
                        createAuto: widget.createAuto,
                      ),
                      )
                      );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:const Color.fromRGBO(64,123,255,1),
                    borderRadius: BorderRadius.circular(10)
                    
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Color.fromRGBO(255,255,255,1),
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            )
        ],
      ) 
    );
  }
}

Widget pointAnswer(dynamic index, dynamic currentIndex, String text, Function setIndex) {
  return GestureDetector(
    onTap: () {
      setIndex(index);
    },
    child: Row(
      children: [
        Container(
          width: 56,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
                color: index == currentIndex
                    ? const Color.fromRGBO(64, 123, 255, 1)
                    : const Color.fromRGBO(173, 179, 188, 1)),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: currentTextStyle.copyWith(
                color: const Color.fromRGBO(85, 85, 85, 1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
  );
}

TextStyle currentTextStyle = const TextStyle(
  fontFamily: "Poppins",
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Color.fromRGBO(51, 51, 51, 1),
);
