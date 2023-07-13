import 'package:eshop/src/models/products.dart';
import 'package:flutter/material.dart';

class PlacedOrder {
  final Product product;
  final String status;
  final DateTime orderDate;
  final DateTime expectedDeliveryDate;
  final double totalAmount;
  final int quantity;

  PlacedOrder({
    required this.product,
    required this.status,
    required this.orderDate,
    required this.expectedDeliveryDate,
    required this.totalAmount,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'expectedDeliveryDate': expectedDeliveryDate.toIso8601String(),
      'totalAmount': totalAmount,
      'quantity': quantity,
    };
  }

  factory PlacedOrder.fromJson(Map<String, dynamic> json) {
    return PlacedOrder(
      product: Product.fromJson(json['product']),
      status: json['status'],
      orderDate: DateTime.parse(json['orderDate']),
      expectedDeliveryDate: DateTime.parse(json['expectedDeliveryDate']),
      totalAmount: json['totalAmount'],
      quantity: json['quantity'],
    );
  }
}
