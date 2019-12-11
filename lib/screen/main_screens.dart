import 'package:flutter/material.dart';
import 'dzikir_screen.dart';
import 'package:dzikr/clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'surah_screen.dart';
import 'package:dzikr/models/surah.dart';
import 'list_hadits_screen.dart';
import 'package:share/share.dart';
import 'package:dzikr/widgets/shalat_widget.dart';
import 'package:dzikr/utils/dzikr_notification.dart';

const products = [
  {
    'icon': FontAwesomeIcons.cloudSun,
    'color': Color(0xFFFFF214),
    'sub': 'dibaca pagi hari',
    'name': 'Dzikir Pagi',
    'route': 'Pagi'
  },
  {
    'icon': FontAwesomeIcons.cloudMoon,
    'color': Color(0xFFFBC02D),
    'sub': 'dibaca sore hari',
    'name': 'Dzikir Petang',
    'route': 'Petang'
  },
  {
    'icon': FontAwesomeIcons.mosque,
    'color': Color(0xFFABC02D),
    'sub': 'dibaca setelah sholat 5 waktu',
    'name': 'Dzikir Sholat',
    'route': 'Shalat'
  },
  {
    'icon': FontAwesomeIcons.bookOpen,
    'color': Color(0xFF1BF02D),
    'sub': '40 hadits yang utama',
    'name': 'Hadits Arba\'in',
    'route': 'Hadits'
  },
  {
    'icon': FontAwesomeIcons.quran,
    'color': Color(0xFF8D6E63),
    'sub': 'Al-quran dan terjemahan',
    'name': 'Al-Quran',
    'route': 'Quran'
  },
  {
    'icon': FontAwesomeIcons.handHoldingHeart,
    'color': Color(0xFFFF5252),
    'sub': 'Sedekah kapanpun di manapun',
    'name': 'Ayo Bersedekah',
    'route': 'Sedekah'
  },
];

class MainScreens extends StatelessWidget {
  BoxDecoration gradientBack() {
    return const BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: const <Color>[
          Color(0xffa5f6B3), // <color name="pelorous">#2596B3</color>
          Color(0xff5FC9E2), // <color name="viking">#5FC9E2</color>
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                Container(
                    child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    //padding: EdgeInsets.all(20.0),
                    decoration: gradientBack(),
                  ),
                )),
                Container(
                    child: SafeArea(
                        child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ShalatWidget(),
                ))),
              ],
            ),
          ),
          Expanded(
              flex: 6,
              child: GridView.builder(
                  itemCount: products.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HaditsList()));
                        } else if (index == 4) {
                          var surah = await Surah().bukaSurah();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SurahScreen(surah: surah)));
                        } else if (index == 5) {
                          Share.share(
                              'Ingatlah kepada Allah (berdzikir) maka Allah akan mengingatmu - https://play.google.com/store/apps/details?id=com.hasanta.studio.dzikr');
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DzikirPagi(
                                    title: products[index]['route'])),
                          );
                        }
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 55,
                                offset: Offset(0.0, 15.0),
                                color: Color(0xFF9DA3B4).withOpacity(0.16))
                          ],
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                products[index]['icon'],
                                size: 40.0,
                                color: products[index]['color'],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 4.0),
                                child: AutoSizeText(
                                  products[index]['name'],
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(0xFF444444),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                '${products[index]['sub']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFFC5CCD6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              DzikrNotification(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
