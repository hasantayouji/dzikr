import 'package:dzikr/dzikir/constant.dart';
import 'package:dzikr/models/quran.dart';
import 'package:flutter/material.dart';
import 'package:dzikr/scrollable_positioned_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:vibration/vibration.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dzikr/models/bookmark.dart';
import 'package:dzikr/models/bookmark_data.dart';

class QuranNewScreen extends StatefulWidget {
  final List<Quran> quran;
  final index;
  final surah;
  final lastRead;
  QuranNewScreen({this.quran, this.index, this.surah, this.lastRead});
  @override
  _QuranNewScreenState createState() => _QuranNewScreenState();
}

class _QuranNewScreenState extends State<QuranNewScreen> {
  bool firsBuild;
  bool bookmarked;
  Color bgColor = Colors.orange[100];
  int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firsBuild = true;
    bookmarked = false;
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void isBookMarked(int index1) {
    setState(() {
      if (!bookmarked) {
        bookmarked = true;
      } else {
        bookmarked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Quran> bacaQuran = widget.quran;
    if ((widget.index != 0 && widget.index != 8) && firsBuild) {
      print('GOOOOOOOOOOOOO ${widget.index}');
      if (bacaQuran != null) bacaQuran.insert(0, Quran(teks: kBasmalah2));
    }
    firsBuild = false;
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[50],
        title: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.loose,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'images/left.png',
                  ),
                  Image.asset('images/right.png'),
                ],
              ),
              Text(
                '${widget.surah}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ScrollablePositionedList.builder(
          itemCount: bacaQuran.length,
          itemBuilder: (context, index) {
            //isBookMarked(index, widget.index);
            return StickyHeaderBuilder(
              overlapHeaders: true,
              builder: (BuildContext context, double stuckAmount) {
                stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (widget.index == 0 || widget.index == 8)
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('images/ayat2.png'),
                          maxRadius: 20.0,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.black87),
                          ))
                      : index == 0
                          ? null
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage('images/ayat2.png'),
                              maxRadius: 20.0,
                              child: Text(
                                '$index',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                );
              },
              content: Container(
                color: Colors.orange[50],
                padding: EdgeInsets.only(left: 50.0, bottom: 4),
                child: Card(
                  elevation: 1,
                  color: index == _selectedIndex ? bgColor : Colors.orange[50],
                  child: ListTile(
                    //selected: bookmarked,
                    onLongPress: () async {
                      bool vibrator = await Vibration.hasVibrator();
                      if (vibrator) {
                        Vibration.vibrate(duration: 100, amplitude: 64);
                      }
//                      SharedPreferences prefs =
//                          await SharedPreferences.getInstance();
//                      int indexSurah = widget.index;
//                      int indexAyat = index;
//                      await prefs.setInt('indeksSurah', indexSurah);
//                      await prefs.setInt('indeksAyat', indexAyat);
                      Provider.of<BookMarkData>(context).setBookMark(BookMark(
                          indeksSurat: widget.index, indeksAyat: index));
//                      BookMarkData().setBookMark(BookMark(
//                          indeksSurat: widget.index, indeksAyat: index));
                      _selectedIndex = index;
                      isBookMarked(_selectedIndex);
                      Alert(
                          context: context,
                          title: 'Simpan Ayat',
                          style: AlertStyle(backgroundColor: Colors.orange[50]),
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.bookOpen,
                                  size: 50,
                                  color: Colors.green[300],
                                ),
                              ),
                              widget.index == 0 || widget.index == 8
                                  ? Text(
                                      'Simpan ${widget.surah} : ${index + 1}?')
                                  : Text('Simpan ${widget.surah} : $index?'),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            )
                          ]).show();
                    },
                    title: (widget.index == 0 || widget.index == 8)
                        ? Text(
                            '${widget.quran[index].teks}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'Indonesia',
                              height: 2.2,
                              fontSize: 22.0,
                            ),
                          )
                        : index == 0
                            ? Text(
                                '${widget.quran[index].teks}',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Basmalah',
                                  fontSize: 100.0,
                                ),
                              )
                            : Text(
                                '${widget.quran[index].teks}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Indonesia',
                                  height: 2.2,
                                  fontSize: 22.0,
                                ),
                              ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: (widget.index == 0 || widget.index == 8)
                          ? Text('${widget.quran[index].terjemahan}')
                          : index == 0
                              ? null
                              : Text('${widget.quran[index].terjemahan}'),
                    ),
                  ),
                ),
              ),
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          initialScrollIndex: widget.lastRead,
        ),
      ),
    );
  }
}
