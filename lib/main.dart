import 'package:flutter/material.dart';
import 'package:miappbar/src/models/audioplayer.dart';

import 'package:miappbar/src/theme/theme.dart';
import 'package:miappbar/src/pages/albumes_player_page.dart';
import 'package:miappbar/src/pages/init_player_page.dart';
import 'package:miappbar/src/pages/music_player_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AudioPlayerModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Bar',
        theme: myTheme,
        // home: InitPlayerPage()
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => InitPlayerPage(),
          'albumes': (BuildContext context) => AlbumesPlayerPage(),
          'player': (BuildContext context) => MusicPlayerPage(),
        },
      ),
    );
  }
}
