import 'package:flutter/material.dart';

class PrintOrderScreen extends StatefulWidget {
  @override
  _PrintOrderScreenState createState() => _PrintOrderScreenState();
}

class _PrintOrderScreenState extends State<PrintOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Печать'),
      ),
      body: Container(
        child: Center(
          child: Text('Print!'),
        ),
      ),
    );
  }
}
