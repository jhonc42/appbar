import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current = new Duration(milliseconds: 0);

  String get songTotalDuration => this.printDuration(this._songDuration);
  String get currentSecond => this.printDuration(this._current);

// porcentaje de donde va la canción en el momento de reproducción.
  double get percentage => (this._songDuration.inSeconds > 0)
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  AnimationController _controller;

  set controller(AnimationController valor) {
    this._controller = valor;
  }

  AnimationController get controller => this._controller;

  bool get playing => this._playing;
  set playing(bool valor) {
    this._playing = valor;
    // como es una propiedad que va a ir cambiando en tiempo de ejecución se necesita que si cambia notifique a todos.
    notifyListeners();
  }

  Duration get songDuration => this._songDuration;
  set songDuration(Duration valor) {
    this._songDuration = valor;
    notifyListeners();
  }

  Duration get current => this._current;
  set current(Duration valor) {
    this._current = valor;
    notifyListeners();
  }

// Función para que devuelva según la duración los minutos y segundos separados por dos puntos :
  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
