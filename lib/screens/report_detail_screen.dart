import 'package:flutter/material.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/models/models.dart';
import 'package:wellnor/screens/print_order_screen.dart';

class ReportDetailScreen extends StatefulWidget {
  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Center(
          child: Text("Приход | Расход товаров"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.local_printshop),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrintOrderScreen(),
                  ),
                );
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 10.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Text(
              "Накладная № 0000001  20.03.2020",
              style: TextStyle(
                  color: Color(0xFF3a3a3b), fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          /*Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                Product item = Product.fromEntity(productList[index]);
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        "assets/images/popular_foods/${item.image}",
                        width: 50,
                        height: 50,
                      ),
                      title: Text('${item.name}'),
                      subtitle: Text('5шт. x 20 000'),
                      trailing: Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          )*/
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFfae3e2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ]),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Общее кол-во: ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "192 шт.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Итого: ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "1 002 000 сум.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Скидка: ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "2 000 сум.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3a3a3b),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Всего: ",
                      style: TextStyle(
                          fontSize: 18,
                          color: kAccentColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "1 000 000 сум.",
                      style: TextStyle(
                          fontSize: 18,
                          color: kAccentColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
