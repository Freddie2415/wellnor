import 'package:flutter/material.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/widgets/widgets.dart';

import 'screens.dart';

class ProductsSupplyScreen extends StatefulWidget {
  @override
  _ProductsSupplyScreenState createState() => _ProductsSupplyScreenState();
}

class _ProductsSupplyScreenState extends State<ProductsSupplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          "Поставка Товаров",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchWidget(),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(
              "Список товаров",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
/*          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container() */ /*ProductCart()*/ /*,
                );
              },
            ),
          )*/
        ],
      ),
      /*bottomNavigationBar: CheckoutPanelWidget(),*/
    );
  }
}
