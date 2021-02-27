import 'package:flutter/material.dart';

import 'package:miappbar/src/widgets/custom_appbar.dart';
import 'package:miappbar/src/widgets/swiper_bands.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(),
          SwiperBands(
            movies: [1, 2, 3, 4, 5],
          )
        ],
      ),
    );
  }
}
