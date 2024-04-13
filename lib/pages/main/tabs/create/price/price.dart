
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/http/user/http_user_car.dart';
import 'package:temp/models/preferences/preferences.dart';
import 'package:temp/pages/main/tabs/profile/user_car/components/create_modal.dart';
import 'package:temp/pages/main/tabs/search/result_search/bar_navigation.dart';
import 'package:temp/repository/create_repo/create_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class Price extends StatefulWidget{
  final Function side;
  final int carId;
  final bool createAuto;
  const Price({required this.side, required this.carId,required this.createAuto, super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {

  TextEditingController priceController= TextEditingController();


  void handleOrder()async{
    if(widget.createAuto){
      int carId=await createCar();
      

      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
               Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/menu'); 
                  
                  userRepository.getUserOrders();
            },
            errorFn: (){},
            future: createOrder(carId),
          ),
        );
      },
      );

    }else{

       showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: CreateModal(
            completed: (){
               Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/menu'); 
                  
                  userRepository.getUserOrders();
            },
            errorFn: (){},
            future: createOrder(widget.carId),
          ),
        );
      },
      );

      
    }
  }


  Future<int> createCar()async{

    ClientCar clientCar=ClientCar(
      modelId: createRepo.carModelId,
      manufacturerId: createRepo.carNameId,
      autoNumber: createRepo.carNumber,
      numberOfSeats: createRepo.numberSeats,
      year: createRepo.carYear,
      preferences: Preferences(
        smoking: createRepo.smoking, 
        luggage: createRepo.luggage, 
        childCarSeat: createRepo.childCarSeat, 
        animals: createRepo.animals
        )
    );
   int carId=await HttpUserCar().createUserCar(clientCar);
  
   return carId;
  }



  Future<int> createOrder(int carId)async{
    Preferences preferences=Preferences(
          smoking: createRepo.smoking, 
          luggage: createRepo.luggage, 
          childCarSeat: createRepo.childCarSeat, 
          animals: createRepo.animals
        );
      RideInfo rideInfo=RideInfo(
          comment: createRepo.comment,
          price: double.parse(priceController.text), 
          numberOfSeats: createRepo.numberSeats,
          preferences: preferences
        );
        
         
        List<Location> locations=[
          Location(
            city: createRepo.fromCity,
            state: createRepo.fromState, 
            sortId: 1, 
            pickUp: true, 
            location: "", 
            longitude: createRepo.fromLng, 
            latitude: createRepo.fromLat, 
            departureTime: createRepo.generateCurrentDateTimeString()
            ),
            Location(
            city: createRepo.toCity, 
            state: createRepo.toState, 
            sortId: 2, 
            pickUp: false, 
            location: "", 
            longitude: createRepo.toLng, 
            latitude: createRepo.toLat, 
            departureTime: DateTime.now().toIso8601String()
            ),
        ];
        UserOrder userOrder=UserOrder(
          clientAutoId: carId,
          rideInfo: rideInfo,  
          locations: locations
        );
        try {
          int code = await HttpUserOrder().createUserOrder(userOrder);
          return code;
        } catch (e) {
          print(e.toString()+"EEEEEEEEEERRRRERRR+ER+E");
          rethrow;
        }
        
        
        
      }
      



  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  bool clicked=false;
  @override
  Widget build(BuildContext context) {
    bool priceValid=true;
    if(priceController.text.isEmpty&&clicked){
      priceValid=false;
    }else{
      priceValid=true;
    }

    checkValid(){

      clicked=true;
      if(priceController.text.isNotEmpty){
                              
                              handleOrder();
      }
      setState(() {
        
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        toolbarOpacity: 0,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 0,right: 0),
        child: Padding(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: SizedBox(
                height: MediaQuery.of(context).size.height,
              child: Column(
               
                children: [
                   BarNavigation(back: true, title: "Price"),
                  Expanded(
                    child: SingleChildScrollView(
                      
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Image.asset("assets/image/price_create.png")
                        ),
                        Container(
                          height: 74,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromRGBO(58,121,215,1)),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 16),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: categorySelected,
                                        borderRadius: BorderRadius.circular(25)
                                      ),
                                        child: SvgPicture.asset(
                                          "assets/svg/money.svg",
                                          fit: BoxFit.scaleDown,
                                        ),
                                    ),
                                  ),
                                  const Text(
                                    "Cash payment"
                                  )
                                ],
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: Container(
                                    height: 18,
                                    width: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(58,121,215,1),
                                      borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                    ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 9.33),
                                child: SvgPicture.asset(
                                  "assets/svg/information.svg"
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  "Payment only in cash after completion of the trip",
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),
                         Padding(
                                      padding: const EdgeInsets.only(top: 24),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: categorySelected,
                                          borderRadius: BorderRadius.circular(10),
                                           border: Border.all(
                                            color: priceValid?categorySelected:Colors.red
                                          )
                                        ),
                                        child: TextField(
                                          controller: priceController,
                                          decoration: const InputDecoration(
                                            
                                            border: InputBorder.none,
                                            hintText: "Specify the price of the trip",
                                            contentPadding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                                          ),
                                          
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              priceController.text="20";
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 56,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(32),
                                              border: Border.all(
                                                color: Color.fromRGBO(173, 179, 188, 1),
                                                width: 1,
                                                style: BorderStyle.solid
                                              )
                                            ),
                                            child: Text(
                                              "\$20",
                                              style: TextStyle(
                                                color: Color.fromRGBO(85, 85, 85, 1),
                                                fontFamily: "SF",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12
                                              ),
                                            ),
                                          ),
                                        ),
                                         Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 4),
                                           child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                priceController.text="40";
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 56,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32),
                                                border: Border.all(
                                                  color: Color.fromRGBO(173, 179, 188, 1),
                                                  width: 1,
                                                  style: BorderStyle.solid
                                                )
                                              ),
                                              child: Text(
                                                "\$40",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(85, 85, 85, 1),
                                                  fontFamily: "SF",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12
                                                ),
                                              ),
                                            ),
                                                                       ),
                                         ),
                                         InkWell(
                                          onTap: () {
                                            setState(() {
                                              priceController.text="60";
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 56,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(32),
                                              border: Border.all(
                                                color: Color.fromRGBO(173, 179, 188, 1),
                                                width: 1,
                                                style: BorderStyle.solid
                                              )
                                            ),
                                            child: Text(
                                              "\$60",
                                              style: TextStyle(
                                                color: Color.fromRGBO(85, 85, 85, 1),
                                                fontFamily: "SF",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12
                                              ),
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    )
                       
                        ],
                      ),
                    ),
                  ),
                  Padding(
                          padding: const EdgeInsets.only(bottom:32,top: 5),
                          child: InkWell(
                            onTap: (){
                              checkValid();
                              
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color:const Color.fromRGBO(64,123,255,1),
                                borderRadius: BorderRadius.circular(10),
                               
                              ),
                              child: const Text(
                                "Create a trip",
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
              ),
            ),
          ),
        ),
      
    );
  }
}



class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey 
      ..strokeWidth = 1 
      ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 3; 

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}

TextStyle currentTextStyle= const TextStyle(
  fontFamily: "Inter",
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Color.fromRGBO(51, 51, 51, 1)
);