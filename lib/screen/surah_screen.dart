import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'quran_new_screen.dart';
import 'package:dzikr/models/quran.dart';
import 'package:provider/provider.dart';
import 'package:dzikr/models/bookmark_data.dart';
import 'package:dzikr/models/bookmark.dart';

class SurahScreen extends StatelessWidget {
  final surah;

  SurahScreen({this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.yellow,
          // Handling label of FAB
          label: Provider.of<BookMark>(context).indeksAyat ==
                      null && // fresh install, NO DATA
                  Provider.of<BookMarkData>(context).surat == null
              ? Text('${surah[0].namaLatin} : 1') // Show Alfatihah : 1
              : Provider.of<BookMarkData>(context).surat == null
                  ? Provider.of<BookMark>(context).indeksSurat == 0 ||
                          Provider.of<BookMark>(context).indeksSurat == 8
                      ? Text(
                          '${surah[Provider.of<BookMark>(context).indeksSurat].namaLatin} : ${Provider.of<BookMark>(context).indeksAyat + 1}')
                      : Text(
                          '${surah[Provider.of<BookMark>(context).indeksSurat].namaLatin} : ${Provider.of<BookMark>(context).indeksAyat}')
                  : Provider.of<BookMarkData>(context).surat == 0 ||
                          Provider.of<BookMarkData>(context).surat == 8
                      ? Text(
                          '${surah[Provider.of<BookMarkData>(context).surat].namaLatin} : ${Provider.of<BookMarkData>(context).ayat + 1}')
                      : Text(
                          '${surah[Provider.of<BookMarkData>(context).surat].namaLatin} : ${Provider.of<BookMarkData>(context).ayat}'),
          icon: Icon(FontAwesomeIcons.bookOpen),

          // Handle Opening Bookmarked ayat & surah
          onPressed: () async {
            var quran = await Quran().bukaQuran(
                index: Provider.of<BookMarkData>(context).surat == null &&
                        Provider.of<BookMark>(context).indeksAyat == null
                    ? 0
                    : Provider.of<BookMarkData>(context).surat == null
                        ? Provider.of<BookMark>(context).indeksSurat
                        : Provider.of<BookMarkData>(context).surat);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Provider.of<BookMark>(context)
                                    .indeksAyat ==
                                null &&
                            Provider.of<BookMarkData>(context).surat == null
                        ? QuranNewScreen(
                            quran: quran,
                            index: 0,
                            surah: '${surah[0].namaLatin}',
                            lastRead: 0,
                          )
                        : Provider.of<BookMarkData>(context).surat == null
                            ? QuranNewScreen(
                                quran: quran,
                                index:
                                    Provider.of<BookMark>(context).indeksSurat,
                                surah:
                                    '${surah[Provider.of<BookMark>(context).indeksSurat].namaLatin}',
                                lastRead:
                                    Provider.of<BookMark>(context).indeksAyat,
                              )
                            : QuranNewScreen(
                                quran: quran,
                                index: Provider.of<BookMarkData>(context).surat,
                                surah:
                                    '${surah[Provider.of<BookMarkData>(context).surat].namaLatin}',
                                lastRead:
                                    Provider.of<BookMarkData>(context).ayat,
                              )));
          }),
      appBar: AppBar(
        title: Text('Surah'),
      ),
      body: ListView.builder(
          itemCount: 114,
          itemBuilder: (context, int index) {
            final item = surah[index];
            return GestureDetector(
              onTap: () async {
                var quran = await Quran().bukaQuran(index: index);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuranNewScreen(
                              quran: quran,
                              index: index,
                              surah: '${item.namaLatin}',
                              lastRead: 0,
                            )));
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: Text('${item.id}')),
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${item.namaArab}',
                                style: TextStyle(fontFamily: 'Indonesia'),
                              ),
                              Text('${item.namaLatin}'),
                            ],
                          )),
                      Expanded(flex: 5, child: Text('${item.terjemah}')),
                      Expanded(flex: 1, child: Text('${item.jumlahAyat}')),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
