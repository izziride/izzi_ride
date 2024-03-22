import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/registration/registration_page.dart';


List<Widget> assetsOnboard=[
  SvgPicture.asset("assets/svg/onboard_4.2.svg",height: 300),
  SvgPicture.asset("assets/svg/onboard_2.2.svg",height: 300),
  SvgPicture.asset("assets/svg/onboard_1.2.svg",height: 300,),
  SvgPicture.asset("assets/svg/onboard_3.2.svg",height: 300),
  
];




class Onboard extends StatefulWidget{
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _MyAppState();
}

class _MyAppState extends State<Onboard> {
  int currentIndex=0;
  Color textColor= Colors.white;
  final PageController controller= PageController();

  bool initialize=false;
 
 
List<String> upText=[
"Don't have a car, but planing a trip and looking for a ride?",
"Going to a trip on your car and don't know how to save on it? It's easy!",
"Did you find your ridemates already?",
"Dont forget to share your experience.",


];

List<Widget> images=[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Find a ride with verified profiles. Choose a car model and comfortable time for your ride. It's easy!",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400,height: 1)),
          ],
          )
        , 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create a ride between Cities and States. Share your costs with ridemates. Save on your trip.",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400,height: 1)),
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Great. Chat with ridemates directly through the app and meet them at the agreed time and location.",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400,height: 1)),
          ],
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("After you arrived, go to the app and rate your ridemates. Share your experience. Let others know more about your ridemates. Make your trip more rewerding with iZZi Ride.",style: TextStyle(color: Colors.white,fontFamily: "SF",fontSize: 18,fontWeight: FontWeight.w400,height: 1)),

          ],
          ),
          
  ];

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    images=[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0)
  )); 
      

double winHeight = MediaQuery.of(context).size.height;

return   Scaffold(
  
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromRGBO(149,182,255, 1),
      ),
      body: 
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: images.length,
                  controller: controller,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex=index%(images.length);
                    });
                  },
                  itemBuilder: (context,index){
                          return  SizedBox(
                              height: winHeight,
                              width: MediaQuery.of(context).size.width,
                              child: 
                                  Stack(
                                    children: [
                                      
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 15,),
                                            Text(upText[index],style: TextStyle(color: textColor,fontSize: 28,fontFamily: "SF",fontWeight: FontWeight.w700,height: 1),),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 30,right: 10),
                                              child: images[index%images.length],
                                            )
                                          ],
                                        ),
                                      ),
                                         Positioned(
                                          top: winHeight/2-150,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: assetsOnboard[index]),
                                          ))
                                    ],
                                  ),
                                  
                               
                              
                            
                          );
                  }
                  ),
              ),
              Column(
                children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (var i=0;i< images.length;i++) buildIndicator(currentIndex==i)
                    ]),
                     Padding(
                  padding: const EdgeInsets.only(left: 11.5,right: 11.5),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: FilledButton(
                      
                      onPressed: (){
                        if(currentIndex==3){
                          Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Registration()
                          ),
                          (route) => false,);
                        }
                        if(currentIndex<3){
                            controller.jumpToPage(currentIndex+1);
                        }
                        
                      
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fixedSize: MaterialStateProperty.all(Size.infinite),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)))
                        
                      ), 
                      child: Container(
                          alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        child:  Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: brandBlue,
                            fontFamily: "SF",
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                            ),
                          ),
                      ),
                      
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Registration()
                          ),
                          (route) => false,);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.5),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ), 
                    child: Text('Skip',style: TextStyle(
                      color: currentIndex==0?Color.fromRGBO(149,182,255, 1):Colors.white,
                      fontSize:18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500 
                    ),),
                    ),
                )
                ],
                
              )
            ],
          ),
       
       
      
        backgroundColor: const Color.fromRGBO(149,182,255, 1),
      );

  }
  Widget buildIndicator(bool isSelected){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: isSelected? 8:6,
      width: isSelected? 32:6,
      decoration:  const BoxDecoration(
        //  border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(79)),
        color: Color.fromRGBO(255, 255, 255, 0.95)
      ),
    );
  }

}