import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/constants/color_view_constants.dart';

Widget widgetCarousel(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return CarouselSlider(
    options: CarouselOptions(
      height: screenHeight * 0.25,
      initialPage: 0,
      autoPlay: true,
      scrollDirection: Axis.horizontal,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 500),
      viewportFraction: 0.8,
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
    ),
    items: [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(1),
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorViewConstants.colorLightWhite,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorViewConstants.colorYellow,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/banner/banner1.png",
                    fit: BoxFit.cover,
                  )));
        },
      );
    }).toList(),
  );
}
