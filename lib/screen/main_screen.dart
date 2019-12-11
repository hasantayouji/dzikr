import 'package:flutter/material.dart';
import 'package:dzikr/screen/dzikir_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF26C6DA),
        title: Text('Dzikir Sesuai Sunnah'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.receipt,
            ),
            title: Text('Dzikir Pagi'),
            subtitle: Text('Dzikir pagi sesuai sunnah'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DzikirPagi(
                            title: 'Pagi',
                          )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
            ),
            title: Text('Dzikir Petang'),
            subtitle: Text('Dzikir petang sesuai sunnah'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DzikirPagi(title: 'Petang')));
            },
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Dzikir Setelah Shalat'),
            subtitle: Text('Dzikir setelah shalat sesuai sunnah'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DzikirPagi(
                            title: 'Sesudah Shalat',
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Hadits Arbain'),
            subtitle: Text('Hadits arbain kumpulan Imam Nawawi'),
          )
        ],
      ),
    );
  }
}
