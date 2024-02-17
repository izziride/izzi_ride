import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as Launcher;
import 'package:temp/http/orders/orders.dart';
class FO_InfoInTheMap extends StatelessWidget {

  final Location location;
  late CameraPosition _initialCameraPosition;

  FO_InfoInTheMap({super.key,required this.location}){
    _initialCameraPosition=CameraPosition(
                            target: LatLng(
                              location.latitude,
                              location.longitude
                              ),
                            zoom: 17  
                            );
  }

  Future<void> _launchUniversalLinkIos(double lat,double lng) async {
  bool? visit=await Launcher.MapLauncher.isMapAvailable(Launcher.MapType.apple);
  if (visit!=null && visit) {
  await Launcher.MapLauncher.showMarker(
    mapType: Launcher.MapType.apple,
    coords:  Launcher.Coords(lat, lng),
    title: location.location,
  );
}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                                    onTapDown: (details)=>_launchUniversalLinkIos(_initialCameraPosition.target.latitude,_initialCameraPosition.target.longitude),
                                          
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                         boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                spreadRadius: 0,
                                                blurRadius: 50,
                                                offset: Offset(0, 10), 
                                              ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start point on the map",
                                            style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                                  fontFamily: "SF",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16
                                                ),
                                          ),
                                          SizedBox(height: 12,),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18)
                                            ),
                                            height: 140,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(18),
                                                  child: GoogleMap(
                                                    rotateGesturesEnabled: false,
                                                    initialCameraPosition: _initialCameraPosition,
                                                    scrollGesturesEnabled: false,
                                                    myLocationButtonEnabled:false,
                                                    
                                                    ),
                                                ),
                                                  Center(
                                                    child: SvgPicture.asset("assets/svg/geo.svg"),
                                                  )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12,)
                                  ,                                    Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              location.location,
                                              style: TextStyle(
                                                    color: Color.fromRGBO(0, 0, 0, 0.87),
                                                    fontFamily: "SF",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14
                                                  ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  );
  }
}