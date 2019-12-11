import 'package:flutter/material.dart';
import 'package:dzikr/dzikir/bacaan_hadits.dart';
import 'package:dzikr/dzikir/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HaditsScreen extends StatefulWidget {
  final index;
  HaditsScreen({this.index});
  @override
  _HaditsScreenState createState() => _HaditsScreenState();
}

class _HaditsScreenState extends State<HaditsScreen> {
  var hadits = BacaHadits().hadits;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Hadits Arba\'in'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: Text(
                '${widget.index + 1}. ${hadits[widget.index].judul}'
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: kJudulStyle,
              ),
            ),
          )),
          Expanded(
              flex: 12,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.orange[50],
                  child: ListTile(
                    title: Text(
                      '${hadits[widget.index].hadits}',
                      style: kAyatStyle,
                      textDirection: TextDirection.rtl,
                    ),
                    subtitle: Text(
                      '${hadits[widget.index].terjemah}',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              )))
        ],
      )),
    );
  }
}
