import 'package:flutter/foundation.dart';

import 'bookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkData extends ChangeNotifier {
  int ayat;
  int surat;
  Future<BookMark> getBookMark() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ayat = preferences.getInt('indeksAyat');
    surat = preferences.getInt('indeksSurah');
    return BookMark(indeksSurat: surat, indeksAyat: ayat);
  }

  Future<void> setBookMark(BookMark bookMark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('indeksAyat', bookMark.indeksAyat);
    preferences.setInt('indeksSurah', bookMark.indeksSurat);
    ayat = bookMark.indeksAyat;
    surat = bookMark.indeksSurat;
    notifyListeners();
  }
}
