import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperBands extends StatelessWidget {
  final List<dynamic> movies;
  SwiperBands({@required this.movies});

  @override
  Widget build(BuildContext context) {
    // para adaptar el swiper a los diferentes tamaños de pantallas de dispositivos se usa el mediaquery para ver las dimesiones:
    final _screensize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      // Aqui de acuerdo al tamaño de la pantalla elige que dimensiones quiere darle del total de la pantallar
      // width: _screensize.width * 0.7,
      // height: _screensize.height * 0.5,
      child: Swiper(
        // Aqui sería lo mismo que el comentario de arriba pero con las tarjetas centradas
        itemWidth: _screensize.width * 0.7,
        itemHeight: _screensize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network("http://via.placeholder.com/350x150",
                  fit: BoxFit.cover));
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
