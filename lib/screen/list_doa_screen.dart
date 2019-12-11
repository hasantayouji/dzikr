import 'package:flutter/material.dart';
import 'package:dzikr/dzikir/bacaan_doa.dart';
import 'package:dzikr/models/doa.dart';
import 'package:dzikr/dzikir/constant.dart';
import 'package:dzikr/screen/doa_screen.dart';

class ListDoa extends StatelessWidget {
  List<Doa> doa = TextDoa().doa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF26C6DA),
        title: Text('Doa-doa para Nabi'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: doa.length,
        itemBuilder: (context, index) {
          final item = doa[index].judul;
          return ListTile(
            title: Text(
              '$item',
              style: kListTitle,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HalamanDoa(index: index)));
            },
          );
        },
      ),
    );
  }
}
