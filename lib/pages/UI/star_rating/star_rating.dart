import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
const double COMPRESSION=2.3;

class UIStarRatingBlack extends StatelessWidget {
  final double rating;
  const UIStarRatingBlack({
    required this.rating,
    super.key
    });

  int percentageFormat(double value){
    
      if(value>=1){
        return 100;
      }
      if(value<=0){
        return 0;
      }
      return (value*100).floor();
  }

  

  @override
  Widget build(BuildContext context) {

    double frame1=0;
    double frame2=0;
    double frame3=0;
    double frame4=0;
    double frame5=0;

    if(rating>=5){
      frame1=1;
      frame2=1;
      frame3=1;
      frame4=1;
      frame5=1;
    }else{
       if(rating>0){
          //frame calculate =  value - value.floor()  if n-frame value >= (n-1)
          //1 frame
          if(rating>=1){
              frame1=1;
          }else{
            frame1=rating-rating.floor();
            if(frame1>0.5){
            frame1= frame4- (frame5-0.5)/COMPRESSION;
            }else{
             frame1= frame4 + (0.5-frame5)/COMPRESSION;
            }
          }
          //2 frame
          if(rating>=2){
              frame2=1;
          }else{
            frame2=rating-rating.floor();
            if(frame2>0.5){
            frame2= frame4- (frame5-0.5)/COMPRESSION;
            }else{
             frame2= frame4 + (0.5-frame5)/COMPRESSION;
            }
          }
          //3 frame
          if(rating>=3){
              frame3=1;
          }else{
            frame3=rating-rating.floor();
            if(frame3>0.5){
            frame3= frame4- (frame5-0.5)/COMPRESSION;
            }else{
             frame3= frame4 + (0.5-frame5)/COMPRESSION;
            }
          }
          //4 frame
          if(rating>=4){
              frame4=1;
          }else{
            frame4=rating-rating.floor();
            if(frame4>0.5){
            frame4= frame4- (frame5-0.5)/COMPRESSION;
            }else{
             frame4= frame4 + (0.5-frame5)/COMPRESSION;
            }
          }
          //5 frame
          if(rating>=5){
              frame5=1;
          }else{
            frame5=rating-rating.floor();
            if(frame5>0.5){
            frame5= frame5- (frame5-0.5)/COMPRESSION;
            }else{
             frame5= frame5 + (0.5-frame5)/COMPRESSION;
            }
          }
          
       }
    }

    return Container(
      height: 18,
      width: 90,
      child: Row(
        children: [
           SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.string(
                '''
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad" x1="0%" y1="100%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame1)}%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame1)}%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                            <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        </linearGradient>
                    </defs>
                    <path d="M9 1.5L11.3175 6.195L16.5 6.9525L12.75 10.605L13.635 15.765L9 13.3275L4.365 15.765L5.25 10.605L1.5 6.9525L6.6825 6.195L9 1.5Z" fill="url(#grad)" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                '''                  
                )
              ),
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.string(
                '''
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad" x1="0%" y1="100%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame2)}%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame2)}%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                            <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        </linearGradient>
                    </defs>
                    <path d="M9 1.5L11.3175 6.195L16.5 6.9525L12.75 10.605L13.635 15.765L9 13.3275L4.365 15.765L5.25 10.605L1.5 6.9525L6.6825 6.195L9 1.5Z" fill="url(#grad)" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                '''                  
                )
              ),
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.string(
                '''
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad" x1="0%" y1="100%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame3)}%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame3)}%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                            <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        </linearGradient>
                    </defs>
                    <path d="M9 1.5L11.3175 6.195L16.5 6.9525L12.75 10.605L13.635 15.765L9 13.3275L4.365 15.765L5.25 10.605L1.5 6.9525L6.6825 6.195L9 1.5Z" fill="url(#grad)" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                '''                  
                )
              ),
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.string(
                '''
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad" x1="0%" y1="100%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame4)}%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame4)}%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                            <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        </linearGradient>
                    </defs>
                    <path d="M9 1.5L11.3175 6.195L16.5 6.9525L12.75 10.605L13.635 15.765L9 13.3275L4.365 15.765L5.25 10.605L1.5 6.9525L6.6825 6.195L9 1.5Z" fill="url(#grad)" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                '''                  
                )
              ),
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.string(
                '''
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="grad" x1="0%" y1="100%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame5)}%" style="stop-color:${"yellow"};stop-opacity:1" />
                            <stop offset="${percentageFormat(frame5)}%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                            <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        </linearGradient>
                    </defs>
                    <path d="M9 1.5L11.3175 6.195L16.5 6.9525L12.75 10.605L13.635 15.765L9 13.3275L4.365 15.765L5.25 10.605L1.5 6.9525L6.6825 6.195L9 1.5Z" fill="url(#grad)" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                '''                  
                )
              )
        ],
      ),
    );
  }
}