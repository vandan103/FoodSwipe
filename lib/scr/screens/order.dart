import 'package:flutter/material.dart';
import 'package:foodswipe/scr/helpers/style.dart';
import 'package:foodswipe/scr/models/order.dart';
import 'package:foodswipe/scr/providers/app.dart';
import 'package:foodswipe/scr/providers/user.dart';
import 'package:foodswipe/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:foodswipe/scr/helpers/screen_navigation.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,

        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index){
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\₹${_order.total }",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description,),
              subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.createdAt).toString()),
              trailing: CustomText(text: _order.status, color: green,),

            );
          }),
    );
  }
}
