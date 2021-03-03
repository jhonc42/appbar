import 'package:flutter/material.dart';

import 'package:miappbar/src/search/search_delegate.dart';

class InitPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Buscar y pedir canción',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white.withOpacity(0.6),
                fontSize: 18)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch(), query: 'Hola');
            },
          )
        ],
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
