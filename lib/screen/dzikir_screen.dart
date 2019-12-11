import 'package:flutter/material.dart';
import 'package:dzikr/dzikir/bacaan_dzikir.dart';
import 'package:dzikr/dzikir/constant.dart';

class DzikirPagi extends StatefulWidget {
  final String title;
  DzikirPagi({@required this.title});

  @override
  _DzikirPagiState createState() => _DzikirPagiState();
}

class _DzikirPagiState extends State<DzikirPagi> {
  int pageIndex = 0;
  int _counter;
  String pageDesc;
  String intro;
  IconData icon;
  Dzikir bacaan = Dzikir();

  String _intro(int index) {
    if (index == 2 || index == 3 || index == 4) {
      return intro = '$kBasmalah\n';
    } else {
      return intro = '';
    }
  }

  void _initCounter(String input) {
    if (input == 'Pagi') {
      _counter = bacaan.dzikirPagi[pageIndex].jumlah;
    } else if (input == 'Petang') {
      _counter = bacaan.dzikirPetang[pageIndex].jumlah;
    } else {
      _counter = bacaan.dzikirShalat[pageIndex].jumlah;
    }
  }

  String _switcherJudul(String input) {
    if (input == 'Pagi') {
      return '${pageIndex + 1}- ${bacaan.dzikirPagi[pageIndex].judul} ${bacaan.dzikirPagi[pageIndex].jumlah}x';
    } else if (input == 'Petang') {
      return '${pageIndex + 1}- ${bacaan.dzikirPetang[pageIndex].judul} ${bacaan.dzikirPetang[pageIndex].jumlah}x';
    } else {
      return '${pageIndex + 1}- ${bacaan.dzikirShalat[pageIndex].judul} ${bacaan.dzikirShalat[pageIndex].jumlah}x';
    }
  }

  String _switcherAyat(String input) {
    if (input == 'Pagi') {
      return '${_intro(pageIndex)}${bacaan.dzikirPagi[pageIndex].ayat}';
    } else if (input == 'Petang') {
      return '${_intro(pageIndex)}${bacaan.dzikirPetang[pageIndex].ayat}';
    } else {
      return '${bacaan.dzikirShalat[pageIndex].ayat}';
    }
  }

  String _switcherTerjemah(String input) {
    if (input == 'Pagi') {
      return '${bacaan.dzikirPagi[pageIndex].terjemahan}';
    } else if (input == 'Petang') {
      return '${bacaan.dzikirPetang[pageIndex].terjemahan}';
    } else {
      return '${bacaan.dzikirShalat[pageIndex].terjemahan}';
    }
  }

  int _panjang(String input) {
    if (input == 'Pagi') {
      return Dzikir().dzikirPagi.length;
    } else if (input == 'Petang') {
      return Dzikir().dzikirPetang.length;
    } else {
      return Dzikir().dzikirShalat.length;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCounter(widget.title);
    icon = Icons.close;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Dzikir ${widget.title} - ${pageIndex + 1}/${_panjang(widget.title)}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _switcherJudul(widget.title),
                      style: kJudulStyle,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Card(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          _switcherAyat(widget.title),
                          style: kAyatStyle,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Card(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          _switcherTerjemah(widget.title),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  pageIndex != 0
                      ? RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red,
                          onPressed: () {
                            if (pageIndex > 0) {
                              setState(() {
                                pageIndex--;
                                _initCounter(widget.title);
                                icon = Icons.close;
                              });
                            }
                          },
                          child: Text('Sebelumnya'),
                        )
                      : SizedBox(width: 50),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFF26C6DA),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.home),
                  ),
                  pageIndex != _panjang(widget.title) - 1
                      ? RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.green[500],
                          onPressed: () {
                            if (pageIndex < _panjang(widget.title) - 1) {
                              setState(() {
                                pageIndex++;
                                _initCounter(widget.title);
                                icon = Icons.close;
                              });
                            }
                          },
                          child: Text('Selanjutnya'),
                        )
                      : SizedBox(
                          width: 50,
                        )
                ],
              ),
            ),
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: () {
//          setState(() {
//            if (_counter > 1) {
//              _counter--;
//            } else {
//              _counter = 0;
//              icon = Icons.check;
//            }
//          });
//        },
//        label: Text(
//          '$_counter',
//          style: kCounter,
//        ),
//        icon: Icon(
//          icon,
//          size: 50,
//        ),
//        backgroundColor: Colors.tealAccent,
//      ),
    );
  }
}
