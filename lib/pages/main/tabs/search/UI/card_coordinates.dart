
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/constants/colors/colors.dart';
import 'package:temp/pages/main/tabs/search/search_city_search/search_city_search.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:temp/repository/user_repo/user_repo.dart';
class CardCoordinates extends StatefulWidget{
  final bool valid;
 final SvgPicture icon;
 final String hint;
 final Function(String,String,double,double,int) update;
 final String name;
 const CardCoordinates({required this.valid, required this.name, required this.update, required this.icon,required this.hint, super.key});

  @override
  State<CardCoordinates> createState() => _CardCoordinatesState();
}

class _CardCoordinatesState extends State<CardCoordinates> {



Future<void> _showAnimation(BuildContext context) async {
  if(!userRepository.isAuth){
    await FlutterPlatformAlert.playAlertSound();
final clickedButton = await FlutterPlatformAlert.showAlert(
      windowTitle: 'No auth',
      text: 'Register to use the functionality',
      alertStyle: AlertButtonStyle.okCancel,
      iconStyle: IconStyle.information,
  );
    if(clickedButton==AlertButton.okButton){
       Navigator.pushNamedAndRemoveUntil(context,"/reg",(route)=>false);
    }
    return;
  }
  ArgumentSetting params = ArgumentSetting(widget.icon,widget.hint);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchCitySearch(update: widget.update,initialCity:widget.name),
      
      settings: RouteSettings(arguments:params), 
    ),
  );
}


@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    print(widget.hint);
   return GestureDetector(
      onTapDown: (details) {
        _showAnimation(context);
  },
     child: Container(
              height: 60,
              decoration: BoxDecoration(
                border:widget.valid?null: Border.all(
                  color:  Colors.red,
                  width: 1,
                  style: BorderStyle.solid
                ),
                color: categorySelected,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 9),
                    child: widget.icon
                  ),
                   Text(
                    widget.name.isNotEmpty?widget.name:widget.hint,
                    style: TextStyle(
                      color: brandBlack,
                      fontSize: 14,
                      fontFamily: "SF",
                      fontWeight: FontWeight.w500
                    ),
                    )
                ],
              ),
             ),
   );
  }
}

