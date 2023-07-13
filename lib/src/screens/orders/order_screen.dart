import 'package:eshop/database.dart';
import 'package:eshop/src/models/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<PlacedOrder> orders = [];
  List<Item> items = [];
  bool waiting = true;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    List<PlacedOrder> Items = await fetchOrdersFromDB(user!.uid.toString());
    setState(() {
      orders = Items;
      items = generateItems(orders);
      waiting = false;
    });
  }

  List<Item> generateItems(List<PlacedOrder> orders) {
    return orders.map<Item>((PlacedOrder order) {
      return Item(
        order: order,
        isExpanded: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: waiting
          ? const Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, backgroundColor: Colors.indigoAccent),
            )
          : ListView(
              children: [
                ExpansionPanelList(
                  elevation: 1,
                  expandedHeaderPadding: const EdgeInsets.all(5.0),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      items[index].isExpanded = !isExpanded;
                    });
                  },
                  children: items.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    NetworkImage(item.order.product.image!),
                              ),
                              title: Text(item.order.product.title!),
                            ));
                      },
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status: ${item.order.status}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Expected Delivery Date: ${DateFormat('EEEE, d MMMM').format(item.order.expectedDeliveryDate)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Order Date: ${DateFormat('EEEE, d MMMM').format(item.order.orderDate)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Quantity: ${item.order.quantity}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total Amount: \$${item.order.totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}

class Item {
  Item({
    required this.order,
    required this.isExpanded,
  });

  PlacedOrder order;
  bool isExpanded;
}
