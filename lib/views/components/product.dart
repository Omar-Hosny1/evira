import 'package:evira/views/screens/product-details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ProductDetails.routeName, arguments: product.id);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Image.network(
                    product.imageUrl,
                  ),
                ),
                Positioned(
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    size: 30,
                  ),
                  top: 5,
                  left: 5,
                ),
              ],
            ),
            Text(
              product.name.length > 20
                  ? '${product.name.substring(0, 17)}...'
                  : product.name,
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),

            Text("${product.price} EGP"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
                onPressed: () {},
                child: Text('Cart', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
