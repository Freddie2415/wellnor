import 'package:flutter/material.dart';

class CartIconWithBadge extends StatelessWidget {
  final int counter;

  const CartIconWithBadge({@required this.counter});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart,
        ),
        counter != 0
            ? Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
