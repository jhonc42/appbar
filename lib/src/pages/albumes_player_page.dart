import 'package:flutter/material.dart';

import 'package:miappbar/src/widgets/custom_appbar.dart';
import 'package:miappbar/src/widgets/photo_artist.dart';
import 'package:miappbar/src/widgets/swiper_bands.dart';

class AlbumesPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(),
          PhotoArtist(),
          SwiperBands(
            movies: [1, 2, 3, 4, 5],
          )
        ],
      ),
    );
  }
}
