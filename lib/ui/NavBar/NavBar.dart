
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_bukizz/controller/order_controller.dart';
import 'package:retailer_bukizz/ui/pending_orders.dart';
import 'package:retailer_bukizz/ui/redelivery.dart';

import '../delivered_order.dart';
import 'nav_bar_controller.dart';


class NavBarScreen extends StatelessWidget {
  final BottomNavController _controller = Get.put(BottomNavController());
  var controller=Get.put(OrderController());
  Future<void> _refreshOrders() async {
    await controller.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('#Admin'),
      // ),
      body: Obx(
            () => IndexedStack(
          index: _controller.currentIndex.value,
          children: [
            // Replace these with your tab views
             HomeScreen(),
             PendingOrderScreen(),
             RedeliveryScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: _controller.currentIndex.value,
          onTap: (index) => {
            _controller.changeTabIndex(index),
            _refreshOrders(),
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Delivered Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending),
              label: 'Pending Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cancel),
              label: 'Redelivery',
            ),
          ],
        ),
      ),
    );
  }
}
