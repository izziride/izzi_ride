import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarNavigation extends StatelessWidget{
  final bool back;
  final String title;
  const BarNavigation({required this.back,required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.only(top:20, bottom: 20),
                child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: back? InkWell(
                              highlightColor: Colors.transparent, 
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 40,
                                  child: SvgPicture.asset(
                                  "assets/svg/back.svg",
                                  fit: BoxFit.none,
                                  height: 24,
                                  width: 24,
                                      ),
                                ),
                              ),
                            ):SizedBox.shrink(),
                          ),
                           Align(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
              );
  }

}