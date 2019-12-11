import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class ListWaktuShalat {
  final isya;
  final subuh;
  final dzuhur;
  final ashar;
  final maghrib;
  final terbit;
  final hijriyah;

  ListWaktuShalat(
      {this.isya,
      this.subuh,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.terbit,
      this.hijriyah});
}
