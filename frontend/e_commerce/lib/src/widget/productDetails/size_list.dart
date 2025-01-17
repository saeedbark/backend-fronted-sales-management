import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/theme/theme.dart';

class SizeList extends StatefulWidget {
  const SizeList({super.key});

  @override
  State<SizeList> createState() => _SizeListState();
}

List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
var currntIndex = 0;

class _SizeListState extends State<SizeList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 15,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              currntIndex = index;
            });

          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.4), width: 2),
              color:Get.isDarkMode ? currntIndex == index ? pinkColor : Colors.black : currntIndex == index ? mainColor.withOpacity(0.5) : Colors.white,
            ),
            child: Text(
              sizeList[index],
              style: TextStyle(color:Get.isDarkMode ? Colors.white: Colors.black,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        itemCount: sizeList.length,
      ),
    );
  }
}
