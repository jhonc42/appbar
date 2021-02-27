import 'package:flutter/material.dart';
import 'package:miappbar/src/pages/music_player_page.dart';
import 'package:miappbar/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Bar',
        theme: myTheme,
        home: MusicPlayerPage());
  }
}
