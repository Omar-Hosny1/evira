import 'package:evira/controllers/wishlist-controller.dart';
import 'package:evira/utils/constants/dimens.dart';
import 'package:evira/views/components/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});
  static const routeName = '/wishlist';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.horizontal_padding,
            right: Dimens.horizontal_padding,
            bottom: Dimens.vertical_padding,
          ),
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<WishlistController>(
                  builder: (controller) => FutureBuilder(
                    future: controller.getUserWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Wait');
                      }
                      if (snapshot.hasError == true) {
                        print(
                            '***************** Wishlist Data ERROR **********************');
                        return Text(snapshot.error.toString());
                      }
                      if (controller.wishlistProducts.isEmpty) {
                        return Text('Start Add Products To Your Wishlist Now');
                      }
                      print(
                          '************** controller.wishlistProducts ****************');
                      print(controller.wishlistProducts);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ProductView(
                          // isAddedToCart: Rx(null),
                          product: controller.wishlistProducts[index],
                          // isFavourite: Rx(null),
                        ),
                        itemCount: controller.wishlistProducts.length,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
