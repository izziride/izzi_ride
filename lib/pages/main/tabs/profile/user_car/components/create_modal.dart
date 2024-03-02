import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class CreateModal extends StatefulWidget {
  final Future<dynamic> future;
  final Function() errorFn;
  final Function() completed;
  const CreateModal({super.key,required this.future,required this.completed,required this.errorFn});

  @override
  State<CreateModal> createState() => _CreateModalState();
}

class _CreateModalState extends State<CreateModal> {




  @override
  Widget build(BuildContext context) {
    return  PopScope (
      canPop: false,
      child: FutureBuilder(
          future: widget.future, 
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return SizedBox(
                height: 70,
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      CircularProgressIndicator(),
                      SizedBox(width: 10,),
                      Text(
                        "wait..."
                      )
                    ],
                  ),
                ),
              );
      
            }
            print(snapshot.connectionState);
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasError){
              
                
              widget.errorFn();
              String errString="Error";
              int code=-1;
              if(snapshot.error is DioException){
                inspect(snapshot.error);
                final err=snapshot.error as DioException;
                if(
                  err.response != null && 
                  err.response!.data != null
                  ){
                  
                    if(
                      err.response!.data!["message"] != null &&
                      err.response!.data!["show_custom_message"] != null &&
                      err.response!.data!["show_custom_message"] is bool &&
                      err.response!.data!["show_custom_message"] == true 
                    )
                    {
                      errString=err.response!.data!["message"].toString();
                    }
                }
              }
             return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250,
                minHeight: 80,
              ),
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 10,),
                            Text(
                              errString,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "SF",
                                fontWeight: FontWeight.w500,
                                color: brandBlack
                              ),
                            ),
                            Icon(Icons.cancel,color: Color.fromARGB(255, 206, 41, 19),),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            height: 40,
                            child:  Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "SF",
                                  fontWeight: FontWeight.w500,
                                  color: brandBlue
                                ),
                              ),
                          ),
                        )
                      ],
                    ),
                ),
                
              );
            }
              Future.delayed(Duration(seconds: 2)).then((value){
                Navigator.pop(context);
                widget.completed();
              });
             return SizedBox(
                height: 80,
                child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SF",
                          fontWeight: FontWeight.w500,
                          color: brandBlack
                        ),
                      ),
                      Icon(Icons.done,color: Colors.green,)
                    ],
                  ),
                
              );
            }
            
            return SizedBox.fromSize();
          },
          
      ),
    );
  }
}