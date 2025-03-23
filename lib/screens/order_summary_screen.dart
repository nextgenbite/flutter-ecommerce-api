import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatefulWidget {
  @override
  const OrderSummaryScreen({super.key});
  @override
  State<OrderSummaryScreen> createState() => _MyOrderSummaryScreenState();
}

class _MyOrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Order Summary')));
  }
}
