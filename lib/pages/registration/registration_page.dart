import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/reg/http_reg.dart';
import 'package:temp/http/user/http_user.dart';
import 'package:temp/localStorage/tokenStorage/token_storage.dart';
import 'package:temp/pages/registration/scene/one_scene.dart';
import 'package:temp/pages/registration/scene/third_scene.dart';
import 'package:temp/pages/registration/scene/two_scene.dart';
import 'package:temp/repository/user_repo/user_repo.dart';


class Registration extends StatefulWidget{
  const Registration({super.key});

  @override
  State<Registration> createState() => _MyAppState();
}
int second=0;
class _MyAppState extends State<Registration> {
  late Timer timer;


   //TEMP
  int otp=0;

  ////required data
  //1scene
  TextEditingController myControllerOneScene=TextEditingController();

  //2scene
  List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> otpFocusNodes = List.generate(
  6,
  (index) => FocusNode(),
  );
  //3scene
  TextEditingController myControllerThirdScene=TextEditingController();


  String otpCode = '';
  String numbers="";
  bool errorLen=false;
  
  int step=0;
  

  
  correctText() async{

      if(myControllerOneScene.text.length!=16){
        setState(() {
          errorLen=true;
        });
        return;
      }
      if(step==0) {
   
        String digitsOnly = myControllerOneScene.text.replaceAll(RegExp(r'[^0-9]'), '');
        digitsOnly="+1$digitsOnly";
       await HttpReg().signIn(digitsOnly);
       
       setState(() {
        errorLen=false;
         step=1;
       });
        
      return;
      }

      if(step==1){
        if(otpControllers[0].text.length<4){
          setState(() {
            otpValid=false;
          });
          return;
        }
        setState(() {
          otpValid=true;
        });
        String codeStr=otpControllers[0].text;
        String phone = myControllerOneScene.text.replaceAll(RegExp(r'[^0-9]'), '');
        phone="+1$phone";

        Map? tokens = await HttpReg().otpVerify(codeStr,phone);
        if(tokens["message"]!=null){
          setState(() {
            errorOtpMessage=tokens["message"];
            otpValid=false;
          });
          return;
        }
         await tokenStorage.setToken(tokens["access_token"],tokens["refresh_token"]);
            if(tokens["is_client_new"]!=null && tokens["is_client_new"]==false){
              
                userRepository.isAuth=true;
                Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
                 
           
            }else{
                setState(() {
                      step=2;
                    });
            }
         
         
        
        return;
      }
      if(step==2){
       int response =await HttpUser().createUser(myControllerThirdScene.text);
       if(response==0){
        
          
          userRepository.isAuth=true;
          Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
          
       }
      }
      
  }

  bool otpValid=true;
  String errorOtpMessage='';
  @override
  void initState() {
   
    super.initState();
  }
  @override
  void dispose() {
    myControllerOneScene.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: const Color.fromRGBO(0, 0, 0, 0),
      statusBarBrightness: Brightness.light
  )); 

   
    double winWidth = MediaQuery.of(context).size.width;
    return   Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          toolbarOpacity: 0,
          elevation: 0,
          
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTapDown: (details) {
         FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          width: winWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: winWidth,
                padding: const EdgeInsets.only( top: 11,bottom: 20,left: 15),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                   
                     Padding(
                      padding: EdgeInsets.only(top: step==0?0:0),
                       child: Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/image/registration.png',width: MediaQuery.of(context).size.width-30, height: MediaQuery.of(context).size.width*0.72,fit: BoxFit.cover,)
                        ),
                     ),
                      step!=0?InkWell(
                    onTap: (){
                      setState(() {
                       
                        step-=1;
                      });
                    },
                     child: Container(
                      
                      
                      constraints: BoxConstraints(
                        minWidth: 40,
                        
                      ),
                      height: 40,
                      padding: EdgeInsets.only(top:9),
                       child: Text(
                        "Back",
                        
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: brandBlue,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                        ),
                        ),
                     ),
                     ):const Offstage(),
                  ],
                )
              ),
              
              SizedBox(
                width: winWidth-30,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step==0
                      ?"What's your number?"
                      :step==1
                      ?"OTP Verification"
                      :"What's your name?",
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                      ),
                      ),
                      step==0
                      ?Text(
                        "Whether you're creating an account to creat a ride or find a ride, lets start with your number",
                        style:  TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        )
                      )
                      :SizedBox.shrink(),
                      step==1&&!otpValid?Text(
                        errorOtpMessage,
                        style:  TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.red
                      )):SizedBox.shrink()
                  ],
                )
                ),
                step==0
                ?OneScene(controller: myControllerOneScene)
                :step==1
                ?TwoScene(otpController: otpControllers, otpFocus: otpFocusNodes,otp:otp,valid:otpValid,errorOtpMessage:errorOtpMessage)
                :ThirdScene(controller: myControllerThirdScene),
                 errorLen? Container(
                  alignment: Alignment.bottomLeft,
                  child:const Padding(
                    padding:  EdgeInsets.only(left: 23,top: 4),
                    child: Text(
                      "Invalid phone number",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
      
                      ),
                      ),
                  )
                  ):Container(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 0),
                      child:  FilledButton(
                          onPressed: (){
                            correctText();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )),
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(64,123,255,1))
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child:   Text(
                               step==0
                               ?"Get code"
                               :step==1
                               ? "Continue"
                               :"Sign up",
                              style:  const TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
                          )
                      ),
                    ),
                    step==0? InkWell(
                      onTap: () {
                        userRepository.isAuth=false;
                        Navigator.pushReplacementNamed(context, "/menu");
                      },
                      child: Container(
                        width: 80,
                        height: 46,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top:12),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: Color.fromRGBO(64,123,255,1),
                            fontFamily: "SF",
                            fontSize: 18,
                            
                            fontWeight: FontWeight.w500
                          ),
                          ),
                      ),
                    ):SizedBox.shrink()
                  ],
                  
                )
            ],
          ),
        ),
      ),
    );
}

}
