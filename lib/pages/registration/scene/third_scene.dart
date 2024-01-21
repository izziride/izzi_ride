import 'package:flutter/material.dart';


class ThirdScene extends StatefulWidget{
  final  TextEditingController controller;
  const ThirdScene({required this.controller, super.key});
  
  @override
  State<StatefulWidget> createState() =>_ThirdSceneState();
  
   
  

}

class _ThirdSceneState extends State<ThirdScene>{

 _ThirdSceneState();

  final FocusNode _focusNode=FocusNode();
  bool _isFocused = false;
  bool errorLen=false;
  
 @override
  void initState() {
    super.initState();
   
    _focusNode.addListener(_onFocusChange);
  }
    @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {

    double winWidth = MediaQuery.of(context).size.width;

    return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SizedBox(
                  width: winWidth-30,
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration:  BoxDecoration(
                      color: const Color.fromRGBO(247,247,253,1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1.6,
                        color: errorLen
                        ? const Color.fromRGBO(255,152,152,1)
                        :_isFocused?Colors.blue :Colors.white
                      )
                    ),
                          child:Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextField(
                              focusNode: _focusNode,
                            textCapitalization: TextCapitalization.sentences,
                              controller: widget.controller,
                              maxLength: 16,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              style:const  TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  
                              ),
                              decoration:const  InputDecoration(
                                hintText: "Your name or nickname",
                                border:InputBorder.none,
                                counterText: ""
                              ),                   
                              onChanged: (value) =>{
                                setState((){
                                  errorLen=false;
                                })
                              },
                            ),
                          ),
                  ),
                ),
              );
  }
}