import 'package:flutter/material.dart';
import 'package:dzikr/dzikir/bacaan_doa.dart';
import 'package:dzikr/dzikir/constant.dart';

class HalamanDoa extends StatelessWidget {
  final int index;
  HalamanDoa({@required this.index});
  TextDoa bacaan = TextDoa();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa-doa para Nabi'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${bacaan.doa[index].judul}',
              style: kJudulStyle,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${bacaan.doa[index].doa}',
              style: kAyatStyle,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
