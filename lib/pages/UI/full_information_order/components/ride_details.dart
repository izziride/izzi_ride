import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temp/http/orders/orders.dart';

class FO_RideDetails extends StatelessWidget {
  final Location startLocation;
  final Location endLocation;
  final int countSeats;
  final Automobile automobile;
  final String comment;
  const FO_RideDetails({
    super.key,
    required this.automobile,
    required this.comment,
    required this.countSeats,
    required this.endLocation,
    required this.startLocation
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
                                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.white
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ride details",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "SF",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),
                                              ),
                                              SizedBox(height: 12,),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Start point",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      startLocation.location,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                                 Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "End point",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      endLocation.location,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Number of places",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      countSeats.toString(),
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),  Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Vehicle",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      automobile.manufacturer+" "+automobile.model+" ("+automobile.year+")",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                                 Container(
                                                padding: EdgeInsets.symmetric(vertical: 12),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  border:Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(245, 245, 245, 1),
                                                      width: 1,
                                                      style: BorderStyle.solid
                                                    )
                                                  )
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text(
                                                      "Comment on the ride",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14
                                                      ),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      comment??"",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(0, 0, 0, 0.87),
                                                        fontFamily: "Inter",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                           
                                            ],
                                          ),
                                        );
  }
}