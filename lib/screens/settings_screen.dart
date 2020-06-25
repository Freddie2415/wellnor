import 'package:flutter/material.dart';
import 'package:wellnor/constants.dart';
import 'package:wellnor/screens/printer_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Настройки'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.print,
                color: kPrimeryVariant,
              ),
              title: Text('Принтер'),
              trailing: Icon(
                Icons.chevron_right,
                color: kPrimeryVariant,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrinterSettingsScreen(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.perm_identity,
                color: kPrimeryVariant,
              ),
              title: Text('Пользователь'),
              trailing: Icon(
                Icons.chevron_right,
                color: kPrimeryVariant,
              ),
              onTap: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => SharedPreferencesDemo(),
//                  ),
//                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
