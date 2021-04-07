import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:miappbar/src/helpers/myLocalizations.dart';
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
        onGenerateTitle: (BuildContext context) =>
            MyLocalizations.of(context).title,
        debugShowCheckedModeBanner: false,
        // title: MyLocalizations.of(context).title,
        theme: myTheme,

        // home: InitPlayerPage()
        localizationsDelegates: [
          const MyLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('fr', ''),
        ],
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
