import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TwoScene extends StatefulWidget{
 final List<TextEditingController> otpController;
 final List<FocusNode> otpFocus;
 final int otp;
 final bool valid;
 final String errorOtpMessage;
  const TwoScene({required this.valid,required this.errorOtpMessage, required this.otp, required this.otpController,required  this.otpFocus, super.key});
  
  @override
  State<StatefulWidget> createState() =>_TwoSceneState();
  
   
  

}

class _TwoSceneState extends State<TwoScene>{
 _TwoSceneState();



  bool errorLen=false;
  
 void _handleFocus(int currentIndex, int nextIndex) {
  if (widget.otpController[currentIndex].text.isNotEmpty){
    widget.otpFocus[currentIndex].unfocus();
    widget.otpFocus[nextIndex].requestFocus();
  }
  
}

  @override
  Widget build(BuildContext context) {

    double winWidth = MediaQuery.of(context).size.width;

    return Padding(
                padding: const EdgeInsets.only(top: 4,left: 11,right: 11),
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                            children: List.generate(
                                4,
                                (index){
                                  
                                  return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: winWidth/4-13.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: widget.valid?Color.fromRGBO(247,247,253,1):Colors.red
                                    ),
                                    color: const Color.fromRGBO(247,247,253,1),
                                    
                                  ),
                                    child: Text(
                                      widget.otpController[0].text.length>=(index+1)?widget.otpController[0].text[index]:"",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                      ),
                                    ),
                                ),
                              );
                                }
                              )
                            

                          ),
                          Opacity(
                            opacity: 1,
                            child: Container(
                              color: Colors.transparent,
                              width: winWidth,
                              child: TextField(
                                          controller: widget.otpController[0],
                                          focusNode: widget.otpFocus[0],
                                           keyboardAppearance: Brightness.dark,
                                           
                                          onChanged: (value) {
                                            
                                            setState(() {
                                              
                                              
                                            });
                                            
                                          },
                                         
                                          textAlign:TextAlign.center, 
                                              maxLength: 4,
                                              style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 24,
                                                color: Colors.transparent
                                                      
                                                
                                                
                                            ),
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.transparent,
                                          cursorWidth: 0,
                                          decoration:const  InputDecoration(
                                              
                                              border:InputBorder.none,
                                              counterText: ""
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            
                                          ],
                                ),
                            ),
                          ),
                    ],
                  ),
                  ),
                );
  }
}