import 'package:flutter/material.dart';
import 'hadits_screen.dart';
import 'package:dzikr/dzikir/bacaan_hadits.dart';

class HaditsList extends StatelessWidget {
//  final hadits;
//  HaditsList({this.hadits});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadits Arba\'in'),
      ),
      body: ListView.builder(
        itemCount: 42,
        itemBuilder: (context, index) {
          final item = BacaHadits().hadits[index].judul;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HaditsScreen(
                            index: index,
                          )));
            },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange[50],
                  child: Text('${index + 1}'),
                ),
                title: Text('$item'.toUpperCase()),
              ),
            ),
          );
        },
      ),
    );
  }
}
