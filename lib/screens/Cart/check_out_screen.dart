import 'package:flutter/material.dart';
import 'package:heaven_book_app/widgets/appbar_custom_widget.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustomWidget(title: 'Order Summary'),
      body: const Center(child: Text('Check Out Screen')),
    );
  }
}
