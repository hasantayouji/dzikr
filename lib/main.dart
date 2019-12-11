import 'package:flutter/material.dart';
import 'models/data_waktu_shalat.dart';
import 'package:dzikr/screen/main_screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'models/waktu_shalat_model.dart';
import 'models/bookmark.dart';
import 'models/bookmark_data.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<WaktuShalatModel>.value(
          value: WaktuShalatData().getData(),
          initialData: WaktuShalatData().initialData(),
          catchError: (context, _) => WaktuShalatData().initialData(),
        ),
        ChangeNotifierProvider<BookMarkData>(
            builder: (context) => BookMarkData()),
        FutureProvider<BookMark>.value(
            value: BookMarkData().getBookMark(),
            catchError: (context, _) => BookMark(indeksSurat: 0, indeksAyat: 0),
            initialData: BookMark(indeksAyat: 0, indeksSurat: 0)),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        home: MainScreens(),
      ),
    );
  }
}
