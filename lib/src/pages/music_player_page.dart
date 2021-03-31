import 'package:flutter/material.dart';
import 'package:miappbar/src/helpers/helpers.dart';
import 'package:miappbar/src/widgets/custom_appbar.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            children: <Widget>[
              CustomAppBar(),
              DiscImageDuration(),
              PlayTitle(),
              Expanded(
                child: Lyrics(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Toma el tamaño total de la pantalla:
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // Toma el 80% de tamaño de la pantalla
      height: screenSize.height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              // Esto hace que el gradiente del background empiece en el centro a la izquierda y termine en la mitad
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [
                Color(0xff33333E),
                Color(0xff201E28),
              ])),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
        child: ListWheelScrollView(
      // para que no se vea el rebote de android cuando se le da scroll con el dedo:
      physics: BouncingScrollPhysics(),
      itemExtent: 42,
      diameterRatio: 1.5,
      children: lyrics
          .map((lineSong) => Text(lineSong,
              style: TextStyle(
                  fontSize: 20, color: Colors.white.withOpacity(0.6))))
          .toList(),
    ));
  }
}

class PlayTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Title Song',
                    style: TextStyle(
                        fontSize: 25, color: Colors.white.withOpacity(0.8))),
                Text('Name Artist',
                    style: TextStyle(
                        fontSize: 15, color: Colors.white.withOpacity(0.5)))
              ],
            ),
            // Ese spacer hace que el botón de play tome todo el campo disponible hacia la derecha y se centre
            Spacer(),
            FloatingActionButton(
              backgroundColor: Color(0xffF8CB51),
              child: Icon(Icons.play_arrow),
              onPressed: () {
                // TODO Botón
              },
            )
          ],
        ));
  }
}

class DiscImageDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          DiscImage(),
          SizedBox(
            width: 20,
          ),
          ProgressBar(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white.withOpacity(0.4));
    return Container(
        child: Column(
      children: <Widget>[
        Text('00:00', style: style),
        SizedBox(height: 10),
        Stack(
          children: <Widget>[
            Container(
                width: 3, height: 120, color: Colors.white.withOpacity(0.1)),
            // Ese positioned coloca el widget en una dirección con respecto al stack, por ejemplo en este caso al revés. Osea de arriba a abajo, por el bottom en cero.
            Positioned(
              bottom: 0,
              child: Container(
                  width: 3, height: 50, color: Colors.white.withOpacity(0.8)),
            )
          ],
        ),
        SizedBox(height: 10),
        Text('00:00', style: style)
      ],
    ));
  }
}

class DiscImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 200,
      height: 200,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image(image: AssetImage('assets/aurora.jpg')),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Color(0xff1C1C25),
                    borderRadius: BorderRadius.circular(100)),
              )
            ],
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1E1C24)])),
    );
  }
}
