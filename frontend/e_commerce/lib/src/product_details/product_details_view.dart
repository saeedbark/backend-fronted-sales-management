import 'package:e_commerce/src/products/products_model.dart';
import 'package:e_commerce/src/widget/productDetails/add_cart.dart';
import 'package:e_commerce/src/widget/productDetails/cloths_info.dart';
import 'package:e_commerce/src/widget/productDetails/image_slider.dart';
import 'package:e_commerce/src/widget/productDetails/size_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModels productModels;

  const ProductDetailsView({super.key, required this.productModels});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ImageSlider(
              //   imageUrl: productModels.image
              // ),
              ClothesInfo(
                title: productModels.title,
                producId: productModels.id,
                rate: productModels.rating?.rate ?? 3.0,
                description: productModels.description ?? 'descr',
              ),
              const SizeList(),
              AddCart(
                price: productModels.price,
                productModels: productModels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
