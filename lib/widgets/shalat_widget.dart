import 'package:dzikr/dzikir/constant.dart';
import 'package:flutter/material.dart';
import 'package:dzikr/models/waktu_shalat_model.dart';
import 'package:provider/provider.dart';

class ShalatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('GUE DIPANGGIL!!!');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Waktu shalat ${Provider.of<WaktuShalatModel>(context).city}',
                  style: kShalatStyle,
                ),
                Text(
                  '${Provider.of<WaktuShalatModel>(context).hijriyah}',
                  style: kShalatStyle,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            color: Color(0x44123456),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Subuh',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).fajr}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Terbit',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).sunrise}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Dzuhur',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).dzuhr}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Ashar',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).ashr}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Maghrib',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).maghrib}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Isya',
                      style: kShalatStyle,
                    ),
                    Text(
                      '${Provider.of<WaktuShalatModel>(context).isya}',
                      style: kShalatStyle,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
