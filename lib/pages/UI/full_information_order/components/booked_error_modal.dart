import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookedErrorModal extends StatefulWidget {
  final int statusCode;
  const BookedErrorModal({super.key,required this.statusCode});

  @override
  State<BookedErrorModal> createState() => _BookedErrorModalState();
}

class _BookedErrorModalState extends State<BookedErrorModal> {


  @override
  Widget build(BuildContext context) {
    
  String errStr=widget.statusCode==223
  ?"Прквышен лимит создания:3"
  :widget.statusCode==224
    ?"Нельзя создать"
    :"Непредвиденная ошибка";
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              errStr,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: const Color.fromARGB(255, 155, 153, 153),
                      width: 0.5
                    )
                  )
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                  "OK",
                  style: TextStyle(
                    color: Color.fromARGB(255, 27, 103, 204),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                              ),
                ),
              ),
              
            ),
          )
        ],
      ),
    );
  }
}