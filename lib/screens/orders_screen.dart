import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Siparisleriniz')),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('Bir Hata Olustu'),
                );
              } else {
                return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(
                              order: orderData.orders[i],
                            )));
              }
            }
          },
        ));
  }
}
