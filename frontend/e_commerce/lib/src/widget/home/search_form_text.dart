import 'package:e_commerce/src/products/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFormText extends StatelessWidget {
   SearchFormText({Key? key}) : super(key: key);
 final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        builder: (_) =>  TextFormField(
          controller: controller.searchController,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          onChanged: (searchName){
         //   controller.addSearchToList(searchName);
          },
          decoration:  InputDecoration(
            fillColor: Colors.white,
            focusColor: Colors.red,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: controller.searchController.text.isNotEmpty ?
            IconButton(onPressed: (){
            //  controller.clearSearch();
            },icon: const Icon(Icons.close,color: Colors.black,),) : null,
            hintText: "Search Name Product Or Price",
            hintStyle: const TextStyle(
                color: Colors.black45, fontSize: 13, fontWeight: FontWeight.bold),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
    );
  }
}
