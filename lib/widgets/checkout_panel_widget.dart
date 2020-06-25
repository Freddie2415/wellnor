import 'package:flutter/material.dart';
import 'package:wellnor/constants.dart';

class CheckoutPanelWidget extends StatelessWidget {
  final Function onCartButtonPress;
  final String countText;
  final String amountText;

  CheckoutPanelWidget(
      {this.onCartButtonPress, this.countText, this.amountText});

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onCartButtonPress,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        color: kAccentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$countText",
                  style: TextStyle(
                    fontSize: 12,
                    color: kPrimeryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "КОРЗИНА",
                    style: TextStyle(
                      fontSize: 16,
                      color: kPrimeryColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "$amountText",
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimeryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
