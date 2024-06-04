import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/http/cars/cars.dart';
import 'package:temp/pages/main/tabs/create/enumMap/enum_map.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';





class NameModal extends StatefulWidget{
 final MyEnum types;
 final Function(String,int) update;
 final int id;
 const NameModal({required this.id, required this.update, required this.types,super.key});
  @override
  State<NameModal> createState() => _NameModalState();
}

class _NameModalState extends State<NameModal> {

//List<CarModel> carModel=[];

String _searchText = '';

final FocusNode _focusNode =FocusNode();
bool _isFocused = false;
@override

  void initState() {
    _focusNode.requestFocus();
    _focusNode.addListener((){
      if(_focusNode.hasFocus&&_searchText.isEmpty){
        setState(() {
          _isFocused=true;
        });
      }if(!_focusNode.hasFocus&&_searchText.isEmpty){
        setState(() {
          _isFocused=false;
        });
      }
    });
    super.initState();
  }

void _clickValue(String model,int id){
    widget.update(model,id);
    Navigator.pop(context);
}

@override
void dispose() {
  _focusNode.dispose();
  super.dispose();
}



Map<MyEnum,dynamic> funcModel ={
  MyEnum.model: ""
};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       BarNavigation(back: true, title: "Select your vehicle make"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(237, 238, 243, 1)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });},
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
        ),
            Visibility(
              visible: _isFocused||_searchText.isNotEmpty,
              child: FutureBuilder<List<CarModel>>(
              future: widget.types==MyEnum.name?CarsHttp().getName(_searchText):CarsHttp().getModel(_searchText, widget.id),
              builder: (BuildContext context, AsyncSnapshot<List<CarModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 43),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return const Text('error'); 
                  } else {
                    List<CarModel>? carModels = snapshot.data;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: carModels!.length<5?carModels.length:5,
                          itemBuilder: (BuildContext context, int index) {
                            CarModel car = carModels[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: InkWell(
                                onTap:(){
                                  _clickValue(carModels[index].name,carModels[index].id);
                                },
                                child:  Container(
                                    decoration: BoxDecoration(
                                      border: Border(top: BorderSide(
                                        color: Color.fromRGBO(233, 235, 238, 1),
                                      ))
                                    ),
                                    height: 48,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                        car.name,
                                        style: const TextStyle(
                                          fontFamily: "SF",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(51,51,51,1)
                                        ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 6),
                                          child: SvgPicture.asset(
                                            "assets/svg/chevron-left.svg"
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                  ),
                                 
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }
              },
                 ),
            ),
      ],
    );
    
  }
}