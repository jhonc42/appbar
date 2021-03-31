import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:animate_do/animate_do.dart';
import 'package:miappbar/src/helpers/helpers.dart';
import 'package:miappbar/src/models/audioplayer.dart';
import 'package:miappbar/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

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

// Esto se genera a partir de cuando se convirtió el statelessWidget a un StateFullWidget el PlayTitleState
class PlayTitle extends StatefulWidget {
  @override
  _PlayTitleState createState() => _PlayTitleState();
}

// El with SingleTickerProvider.... es necesario para que no le salga error al momento de inicializar el controlador en el initState pasandole el argumento this.
//
class _PlayTitleState extends State<PlayTitle>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  AnimationController playAnimation;
  bool firstTime = true;

  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    // es mejor inicializar el controlador aqui en el initState, acordarse que lo que hace es instanciar esa clase AnimationController pero el new ya está implicito en dart:
    playAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  // SIEMPRE QUE TENGA UN CONTROLADOR ACOSTUMBRARSE A IMPLEMENTAR EL DISPOSE COMO BUENA PRÁCTICA.
  @override
  void dispose() {
    // AQUI SE LIBERA EL CONTROLADOR PLAYANIMATION CON EL DISPOSE COMO BUENA PRÁCTICA.
    this.playAnimation.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        // el listen en false en este caso es porque no se va a necesitar que actualice widgets en la vista.
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));
    // el currentPosition del assetAudioPlayer (package que hemos instalado) es un stream, por lo cual con el listen ud va escuchando en donde va la canción
    // el duration que recibe el listen del Stream es de tipo Duration.
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });
    // en lo siguiente se hace referencia a current como la canción actual, arriba era el currentPosition
    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });
  }

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
              // child: Icon(Icons.play_arrow),
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: playAnimation,
              ),
              onPressed: () {
                // OJO: se coloca el listen en false despues del context porque está dentro de un onPresed y esto es una condición del cuando se usa provider como manejador de estado de la app.
                final audioPlayerModel =
                    Provider.of<AudioPlayerModel>(context, listen: false);
                // Acá se dispara la animación del botón ya sea a play o a pausa con el forward y reverse. Dependiendo de si está reproduciendo o no con la variables isPlaying
                if (this.isPlaying) {
                  playAnimation.reverse();
                  this.isPlaying = false;
                  audioPlayerModel.controller.stop();
                } else {
                  playAnimation.forward();
                  this.isPlaying = true;
                  audioPlayerModel.controller.repeat();
                }

                if (firstTime) {
                  this.open();
                  firstTime = false;
                } else {
                  assetAudioPlayer.playOrPause();
                }
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

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final percentage = audioPlayerModel.percentage;

    return Container(
        child: Column(
      children: <Widget>[
        Text('${audioPlayerModel.songTotalDuration}', style: style),
        SizedBox(height: 10),
        Stack(
          children: <Widget>[
            Container(
                width: 3, height: 120, color: Colors.white.withOpacity(0.1)),
            // Ese positioned coloca el widget en una dirección con respecto al stack, por ejemplo en este caso al revés. Osea de arriba a abajo, por el bottom en cero.
            Positioned(
              bottom: 0,
              child: Container(
                  width: 3,
                  height: 120 * percentage,
                  color: Colors.white.withOpacity(0.8)),
            )
          ],
        ),
        SizedBox(height: 10),
        Text('${audioPlayerModel.currentSecond}', style: style)
      ],
    ));
  }
}

class DiscImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: EdgeInsets.all(20),
      width: 200,
      height: 200,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SpinPerfect(
                  duration: Duration(seconds: 10),
                  animate: false,
                  infinite: true,
                  manualTrigger: true,
                  controller: (animationController) =>
                      audioPlayerModel.controller = animationController,
                  child: Image(image: AssetImage('assets/aurora.jpg'))),
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
