import 'package:dzikr/utils/user_location.dart';
import 'waktu_shalat_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'lokasi.dart';

class WaktuShalatData {
  initialData() {
    return WaktuShalatModel(
      fajr: '4.30',
      sunrise: '6.00',
      dzuhr: '12.00',
      ashr: '15.00',
      maghrib: '18.00',
      isya: '19.00',
      city: 'Jakarta',
      hijriyah: '1 Syawal 1500 H',
    );
  }

  Future<WaktuShalatModel> savedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> data = preferences.getStringList('data');
    if (data != null) {
      return WaktuShalatModel(
          fajr: data[0],
          sunrise: data[1],
          dzuhr: data[2],
          ashr: data[3],
          maghrib: data[4],
          isya: data[5],
          city: data[6],
          hijriyah: data[7]);
    } else {
      return initialData();
    }
  }

  Future<WaktuShalatModel> getData() async {
    String city;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Lokasi lokasi = await UserLocation().getLocation();
    double lat = lokasi.latitude;
    double long = lokasi.longitude;
    city = await UserLocation().getPlaceMark(lat, long) ?? 'Jakarta';
    WaktuShalatModel waktuShalatData = await dataShalats(lat, long, city);

    List<String> dataShalat = [
      waktuShalatData.fajr,
      waktuShalatData.sunrise,
      waktuShalatData.dzuhr,
      waktuShalatData.ashr,
      waktuShalatData.maghrib,
      waktuShalatData.isya,
      waktuShalatData.city,
      waktuShalatData.hijriyah
    ];
    preferences.setStringList('data', dataShalat);
    return waktuShalatData;
  }

  Future<WaktuShalatModel> dataShalats(
      double lat, double long, String city) async {
    try {
      http.Response response = await http.get(
          'https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$long&method=99&methodSettings=19.44,null,18.55&tune=0,0,-3,3,3,2.92,3,');
      if (response.statusCode == 200) {
        String data = response.body;
        var waktuShalat = jsonDecode(data);
        return WaktuShalatModel(
            fajr: waktuShalat['data']['timings']['Fajr'],
            sunrise: waktuShalat['data']['timings']['Sunrise'],
            dzuhr: waktuShalat['data']['timings']['Dhuhr'],
            ashr: waktuShalat['data']['timings']['Asr'],
            maghrib: waktuShalat['data']['timings']['Maghrib'],
            isya: waktuShalat['data']['timings']['Isha'],
            hijriyah:
                '${waktuShalat['data']['date']['hijri']['day']} ${waktuShalat['data']['date']['hijri']['month']['en']} ${waktuShalat['data']['date']['hijri']['year']} H',
            city: city);
      } else {
        print('ERROOOOOOOOR ${response.statusCode}');
        return await savedData();
      }
    } catch (e) {
      return await savedData();
    }
  }
}
