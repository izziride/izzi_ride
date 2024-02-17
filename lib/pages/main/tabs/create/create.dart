
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:temp/http/orders/orders.dart';
import 'package:temp/pages/main/tabs/create/auto/auto.dart';
import 'package:temp/pages/main/tabs/widgets/card_order.dart';
import 'package:temp/pages/main/tabs/create/create_title.dart';
import 'package:temp/pages/main/tabs/emptyState/empty_state.dart';
import 'package:temp/repository/create_repo/create_repo.dart';
import 'package:temp/repository/user_repo/user_repo.dart';

class CreateTab extends StatefulWidget{
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTab();
}

class _CreateTab extends State<CreateTab> {

  DateTime date=DateTime.now();

  void updateDate(DateTime newDate){
    setState(() {
      date=newDate;
    });
  }

  void updateData(){
    setState(() {
      
    });
  }

  DateTime time=DateTime.now();
  void updateTime(DateTime newTime){
    setState(() {
      time=newTime;
    });
  }




void _showDialogPage(BuildContext context){
  DateTime validDate=DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
 
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Auto(
        side:updateData
      )),
      
      );
}
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    bool auth = userRepository.isAuth;
    if(!auth){
      return const EmptyStateAllPAge();
    }

    return Observer(
      builder: (context) {
        print(userRepository.isFirstLoaded);
        if(!userRepository.isFirstLoaded && userRepository.userOrders.isEmpty){
          userRepository.getUserOrders();
        }
        if(!userRepository.isFirstLoaded){
          return const Center(
            child:  CircularProgressIndicator(),
          );
        }
        if(userRepository.userOrders.isEmpty){
          return CreateTitle(side: updateData, back: false);
        }
        List<DriverOrder> orders = userRepository.userOrders;
        print("object");
        return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async {
                    setState(() {
                      userRepository.isFirstLoaded=false;
                      userRepository.getUserOrders();
                    });
                  },
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return CardOrder(driverOrder: orders[index],side: (){setState(() {
                        
                      });},full: false,);
                    },
                    ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                  child: InkWell(
                  onTap: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                          Material(
                            child: Scaffold( 
                              appBar:AppBar(
                                systemOverlayStyle: SystemUiOverlayStyle.dark,
                                toolbarHeight: 0,
                                backgroundColor: Colors.white,
                                toolbarOpacity: 0,
                                elevation: 1,
                                
                            ), 
                              body: CreateTitle(side: updateData, back: true,),
                              )
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
                      "Create a ride",
                      style: TextStyle(
                        color: Color.fromRGBO(255,255,255,1),
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                              ),
                ),
            ],
          );
      },
      ); 
    
  }
}