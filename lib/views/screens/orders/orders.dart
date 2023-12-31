import 'package:evira/controllers/order-controller.dart';
import 'package:evira/utils/constants/dimens.dart';
import 'package:evira/utils/helpers/error-handler.dart';
import 'package:evira/views/components/common/main-drawer.dart';
import 'package:evira/views/components/orders/order-item.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.horizontal_padding,
            right: Dimens.horizontal_padding,
            bottom: Dimens.vertical_padding,
          ),
          child: FutureBuilder(
            future: OrderController.get.getUserOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError == true) {
                return Center(
                  child: Text(
                    formatErrorMessage(
                      snapshot.error.toString(),
                    ),
                  ),
                );
              }
              final userOrders = snapshot.data;
              if (userOrders == null) {
                return const Center(
                    child: Text(
                  'No Orders, Order Some Products Now...',
                  textAlign: TextAlign.center,
                ));
              }
              final orders = userOrders.orders.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderItem(
                    order: orders[index],
                    key: ValueKey(orders[index].date),
                  );
                },
                itemCount: orders.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
