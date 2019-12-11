//import 'package:flutter/material.dart';
//import 'package:dzikr/dzikir/constant.dart';
//
//class QuranScreen extends StatefulWidget {
//  final quran;
//  final index;
//  final surah;
//  QuranScreen({this.quran, this.index, this.surah});
//  @override
//  _QuranScreenState createState() => _QuranScreenState();
//}
//
//class _QuranScreenState extends State<QuranScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.orange[50],
//      body: Builder(builder: (BuildContext context) {
//        return SafeArea(
//          child: CustomScrollView(
//            slivers: _buildSlivers(context),
//          ),
//        );
//      }),
//    );
//  }
//
//  List<Widget> _buildSlivers(BuildContext context) {
//    List<Widget> slivers = List<Widget>();
//    int i = 0;
//    slivers.add(SliverAppBar(
//      floating: true,
//      iconTheme: IconThemeData.fallback(),
//      pinned: false,
//      snap: false,
//      centerTitle: true,
//      leading: CircleAvatar(
//        backgroundColor: Colors.orange[200],
//        maxRadius: 30,
//        child: Text('${widget.index + 1}'),
//      ),
//      actions: <Widget>[
//        CircleAvatar(
//          backgroundColor: Colors.orange[200],
//          maxRadius: 30,
//          child: Text('${widget.quran.length}'),
//        )
//      ],
//      title: Text(
//        '${widget.surah}',
//        style: TextStyle(color: Colors.black),
//      ),
//      backgroundColor: Colors.orange[100],
//    ));
//    if (widget.index == 0 || widget.index == 8) {
//    } else {
//      slivers.add(SliverList(
//          delegate: SliverChildListDelegate.fixed([
//        Text(
//          '$kBasmalah2',
//          textAlign: TextAlign.center,
//          style: kBasmalahStyle,
//        )
//      ])));
//      print('${widget.index}');
//    }
//    slivers.addAll(_buildSideHeaderGrids(context, i, widget.quran.length));
//    return slivers;
//  }
//
//  List<Widget> _buildSideHeaderGrids(
//      BuildContext context, int firstIndex, int count) {
//    return List.generate(count, (sliverIndex) {
//      sliverIndex += firstIndex;
//      return SliverStickyHeader(
//          overlapsContent: true,
//          header: _buildSideHeader(context, sliverIndex),
//          sliver: SliverPadding(
//            padding: EdgeInsets.only(left: 50),
//            sliver: SliverList(
//              delegate: SliverChildBuilderDelegate(
//                  (context, i) => Card(
//                        color: Colors.orange[50],
//                        child: ListTile(
//                          contentPadding: EdgeInsets.all(0),
//                          title: Container(
//                              padding: EdgeInsets.symmetric(
//                                  vertical: 16, horizontal: 8),
//                              color: Colors.orange[50],
//                              child: Text(
//                                '${widget.quran[sliverIndex].teks}',
//                                textDirection: TextDirection.rtl,
//                                style: TextStyle(
//                                    height: 1.3,
//                                    fontFamily: 'Indonesia',
//                                    fontSize: 22),
//                              )),
//                          subtitle: Container(
//                              padding:
//                                  EdgeInsets.only(left: 8, bottom: 8, right: 8),
//                              color: Colors.orange[50],
//                              child: Text(
//                                '${widget.quran[sliverIndex].terjemahan}',
//                                textAlign: TextAlign.justify,
//                              )),
//                        ),
//                      ),
//                  childCount: 1),
//            ),
//          ));
//    });
//  }
//
//  Widget _buildSideHeader(BuildContext context, int index, {String text}) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//      child: Align(
//        alignment: Alignment.centerLeft,
//        child: SizedBox(
//          height: 60.0,
//          width: 35.0,
//          child: CircleAvatar(
//            backgroundColor: Colors.orangeAccent,
//            foregroundColor: Colors.black54,
//            child: Center(
//              child: Text(
//                '${widget.quran[index].ayatArab}',
//                textAlign: TextAlign.center,
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
