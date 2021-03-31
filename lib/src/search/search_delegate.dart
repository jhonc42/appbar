import 'package:flutter/material.dart';
import 'package:miappbar/src/models/Song.dart';

class DataSearch extends SearchDelegate {
  final List<Song> songs = [
    new Song(name: "Brave New World - Iron Maiden", type: 0),
    new Song(name: "Nothing else matters - Metallica", type: 0),
    new Song(name: "Don\'t stop believe in - Journey", type: 0),
    new Song(name: "Hysteria - Def Leppard", type: 0),
    new Song(name: "Verano traidor - Vilma Palma e Vampiros", type: 0),
    new Song(name: "Cordillera -  Enanitos Verdes", type: 0),
    new Song(name: "Screaming in the night - Krokus", type: 0),
    new Song(name: "Guitarras Blancas - Enanitos Verdes", type: 0),
    new Song(name: "Reino Olvidado - Rata Blanca", type: 0),
    new Song(name: "Soda Stereo", type: 1),
    new Song(name: "Iron Maiden", type: 1),
    new Song(name: "Journey", type: 1),
    new Song(name: "Def Leppard", type: 1)
  ];

  final List<Song> recommendedSongs = [
    new Song(name: "Guitarras Blancas - Enanitos Verdes", type: 0),
    new Song(name: "Iron Maiden", type: 1),
    new Song(name: "Journey", type: 1),
    new Song(name: "Brave New World - Iron Maiden", type: 0)
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro appbar, es el icono de cancelar o borrar lo que se escriba en el textbox
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // es un Icono a la izquierda del appbar, el icono al principio del appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        // close(context, null);
        // Navigator.pushNamed(context, '/');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // es el que crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe.

    final List<Song> suggestedList = (query.isEmpty)
        ? recommendedSongs
        : songs
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    // TODO cambiar esto por un FutureBuilder cuando tenga la API ver video 123 4:48 seg
    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: (suggestedList[i].type == 0)
              ? Icon(Icons.music_note)
              : Icon(Icons.group_outlined),
          title: Text(suggestedList[i].name),
          onTap: () {
            close(context, null);
            if (suggestedList[i].type == 0) {
              Navigator.pushNamed(context, 'player');
            } else {
              Navigator.pushNamed(context, 'albumes');
            }
          },
        );
      },
    );
  }
}
