import 'package:flutter/material.dart';
import 'package:wellnor/screens/screens.dart';
import 'package:wellnor/constants.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text('Отчёты'),
          actions: <Widget>[ReportFilterButton()],
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Приход'),
            ),
            Tab(
              child: Text('Расход'),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: kAccentColor,
                  ),
                  title: Text('Приход товаров'),
                  subtitle: Text('20.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '20 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.cancel,
                    color: kAccentColor,
                  ),
                  title: Text('Приход товаров'),
                  subtitle: Text('23.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '20 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.hourglass_empty,
                    color: kAccentColor,
                  ),
                  title: Text('Приход товаров'),
                  subtitle: Text('29.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '250 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '1020 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: kAccentColor,
                  ),
                  title: Text('Расход товаров'),
                  subtitle: Text('20.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '20 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: kAccentColor,
                  ),
                  title: Text('Расход товаров'),
                  subtitle: Text('20.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '20 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: kAccentColor,
                  ),
                  title: Text('Расход товаров'),
                  subtitle: Text('20.03.2020'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '10 000 сум',
                        style: TextStyle(color: kAccentColor),
                      ),
                      Text(
                        '20 шт.',
                        style: TextStyle(color: kPrimeryVariant),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReportFilterButton extends StatefulWidget {
  const ReportFilterButton({
    Key key,
  }) : super(key: key);

  @override
  _ReportFilterButtonState createState() => _ReportFilterButtonState();
}

enum ReportFilterOptions { last, first, active, pending, canceled }

class _ReportFilterButtonState extends State<ReportFilterButton> {
  ReportFilterOptions _selection;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ReportFilterOptions>(
      onSelected: (ReportFilterOptions result) {
        setState(() {
          _selection = result;
        });
      },
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ReportFilterOptions>>[
        const PopupMenuItem<ReportFilterOptions>(
          value: ReportFilterOptions.last,
          child: Text('Последние'),
        ),
        const PopupMenuItem<ReportFilterOptions>(
          value: ReportFilterOptions.first,
          child: Text('Старые'),
        ),
        const PopupMenuItem<ReportFilterOptions>(
          value: ReportFilterOptions.active,
          child: Text('Активные'),
        ),
        const PopupMenuItem<ReportFilterOptions>(
          value: ReportFilterOptions.pending,
          child: Text('В ожидании'),
        ),
        const PopupMenuItem<ReportFilterOptions>(
          value: ReportFilterOptions.canceled,
          child: Text('Отменённые'),
        ),
      ],
    );
  }
}
