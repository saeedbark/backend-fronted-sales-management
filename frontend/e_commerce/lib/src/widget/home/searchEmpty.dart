import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchEmpty extends StatelessWidget {
  const SearchEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
           width: 100,
            height: 100,
            child: IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 100,color: Get.isDarkMode ? Colors.pink: Colors.grey,))),
        const SizedBox(height: 15),
        Text('No Result Found ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Get.isDarkMode ? Colors.white: Colors.black,),),
        const SizedBox(height: 10),
        Text('We can\'t find any item matching yout search ',style: TextStyle(color: Get.isDarkMode ? Colors.white: Colors.black,),),


      ],
    );
  }
}
