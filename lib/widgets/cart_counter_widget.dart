import 'package:flutter/material.dart';
import 'package:wellnor/constants.dart';

class CardCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove,
              color: kAccentColor,
            ),
            onPressed: () {},
          ),
          Text(
            '1',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: kAccentColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
