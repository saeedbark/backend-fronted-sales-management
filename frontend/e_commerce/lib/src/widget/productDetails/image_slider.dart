import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/src/widget/productDetails/color_picker.dart';
import 'package:e_commerce/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final String imageUrl;
  const ImageSlider({super.key, required this.imageUrl});
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

CarouselController carouselController = CarouselController();

class _ImageSliderState extends State<ImageSlider> {
  int cerrentPage = 0;
  int cerrenColor = 0;
  List<Color> colorSelected = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.pinkAccent,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: carouselController,
          options: CarouselOptions(
              height: 500,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reson) {
                setState(() {
                  cerrentPage = index;
                });
              }),
          itemBuilder: (context, index, real) => Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 180,
          child: AnimatedSmoothIndicator(
            activeIndex: cerrentPage,
            count: 3,
            effect: ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Get.isDarkMode ? pinkColor : mainColor,
              dotColor: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: Container(
            height: 200,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30)),
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    cerrenColor = index;
                  });
                },
                child: ColorPicker(
                  outerBorder: cerrenColor == index,
                  color: colorSelected[index],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 3,
              ),
              itemCount: colorSelected.length,
            ),
          ),
        ),
      ],
    );
  }
}
