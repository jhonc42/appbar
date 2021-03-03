import 'package:flutter/material.dart';

class PhotoArtist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
        height: 150.0,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://www.rockzonemag.com/wp-content/uploads/2020/03/Metallica-Vinyl-Club.jpeg"),
            // image: NetworkImage(
            //     "https://www.rockaxis.com/img/newsList/2269825.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
