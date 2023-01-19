import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/list_manager.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        CarouselSlider(
          items: ListManager.imageList
              .map(
                (item) => Image.asset(
              item["image_path"],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
              .toList(),
          carouselController: carouselController,
          options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              aspectRatio: 2,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ListManager.imageList.asMap().entries.map((entry) {
              if (kDebugMode) {
                print(entry);
              }
              if (kDebugMode) {
                print(entry.key);
              }
              return GestureDetector(
                onTap: () =>
                    carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 17 : 7,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3.0,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      color: currentIndex == entry.key
                          ? ColorManager.primaryUi
                          : Colors.lightGreenAccent),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
