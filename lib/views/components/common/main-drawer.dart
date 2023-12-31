import 'package:evira/controllers/cart-controller.dart';
import 'package:evira/views/components/common/user-list-tile.dart';
import 'package:evira/views/screens/cart.dart';
import 'package:evira/views/screens/home.dart';
import 'package:evira/views/screens/orders/orders.dart';
import 'package:evira/views/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserListTile(),
          // ListTile(
          //   onTap: () async {
          //     await ProductDS().raiseProduct();
          //   },
          //   title: const Text('UIIIII'),
          // ),
          ListTile(
            style: ListTileStyle.drawer,
            onTap: () {
              Get.back(closeOverlays: true);
              if (Get.currentRoute != Home.routeName) {
                Get.offAllNamed(Home.routeName);
              }
            },
            title: const Text('Home'),
          ),
          ListTile(
            style: ListTileStyle.drawer,
            onTap: () {
              Get.back(closeOverlays: true);
              if (Get.currentRoute != Orders.routeName) {
                Get.offAllNamed(Orders.routeName);
              }
            },
            title: const Text('Orders'),
          ),
          ListTile(
            style: ListTileStyle.drawer,
            onTap: () {
              Get.back(closeOverlays: true);
              if (Get.currentRoute != Wishlist.routeName) {
                Get.offAllNamed(Wishlist.routeName);
              }
            },
            title: const Text('Wishlist'),
          ),
          ListTile(
            style: ListTileStyle.drawer,
            onTap: () {
              Get.back(closeOverlays: true);
              if (Get.currentRoute != Cart.routeName) {
                CartController.get.resetIsAbleToAddOrRemove();
                Get.offAllNamed(Cart.routeName);
              }
            },
            title: const Text('Cart'),
          ),
        ],
      ),
    );
  }
}
