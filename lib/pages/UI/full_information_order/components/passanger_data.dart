import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:string_to_color/string_to_color.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/http/chats/http_chats.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/UI/app_popup.dart';
import 'package:temp/pages/main/tabs/chat/chat_page.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class FO_PassangerData extends StatelessWidget {
  final List<Travelers>travelers;
  final int orderId;
  const FO_PassangerData({super.key,required this.travelers,required this.orderId});


  openModalDeleteUser(String name,int clientId,BuildContext context){
        showDialog(
          context: context, 
          builder: (context){
            return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: AppPopup(warning: false, title: "Delete User?", description: "Do you really want to\ndelete"+name+"?", pressYes: ()async{
                      
                      await userRepository.deleteUserByOrder(orderId, clientId);
                      
                      Navigator.pop(context);
                    }, pressNo: ()=>Navigator.pop(context)),
                    );
          }
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            "Passenger data",
                                            style: TextStyle(
                                                            fontFamily: "SF",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: brandBlack
                                                          ),
                                          ),
                                        ),
                                        travelers.length==0
                                        ?
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top:12,bottom: 12),
                                          height: 88,
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color.fromRGBO(247, 247, 253, 1)
                                              ),
                                              child: SvgPicture.asset("assets/svg/userSiluete.svg"),
                                            ),
                                            SizedBox(height: 8,),
                                            Text(
                                              "You don't have travel companions yet\nfor a joint ride",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                                fontFamily: "SF",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14
                                              ),
                                            )
                                            ],
                                          ),
                                        )
                                        : Column(
                                          children: [
                                              
                                              for (int i=0,a = -(travelers.length-1); a < travelers.length; a++,i++ ) 
                                              i%2==1?Container(height: 2,color: const Color.fromARGB(255, 214, 214, 214),margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),) :
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child:  Row( 
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                              margin: EdgeInsets.all(3),
                                                              width: 40,
                                                              height: 40,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: ColorUtils.stringToColor(travelers[((i+1)/2).toInt()].nickname)
                                                              ),
                                                              child:Text(
                                                                      travelers[((i+1)/2).toInt()].nickname[0],
                                                                      style: TextStyle(
                                                                        fontFamily: "SF",
                                                                        fontSize: 25,
                                                                      ),
                                                                    ),
                                                            ),
                                                
                                                         
                                                      
                                                      SizedBox(width: 10,),
                                                      Text(
                                                        travelers[((i+1)/2).toInt()].nickname,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      ],
                                                    ),
                                                      
                                                      Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () async{
                                                                  int chatId=await HttpChats().getChatId(orderId,travelers[((i+1)/2).toInt()].userId);
                                                                    
                                                                    Navigator.push(
                                                                      context, 
                                                                      MaterialPageRoute(builder: (context) => MessagePage(chatId: chatId),)
                                                                      );
                                                                },
                                                                child: Icon(Icons.message,color: brandBlue,size: 20)),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                    openModalDeleteUser(travelers[((i+1)/2).toInt()].nickname,travelers[((i+1)/2).toInt()].userId,context);
                                                                  },
                                                                child: Icon(Icons.dangerous,color: Colors.red,size: 20,)),
                                                            ],
                                                          )
                                                        ],
                                                      ),

                                                    ],),
                                               
                                              )
                                            
                                          ],
                                        )
                                      ],
                                    ),
                                  );
  }
}