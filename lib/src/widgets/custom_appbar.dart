import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.chevronLeft),
              onPressed: () {
                // close(context, null);
                Navigator.pushNamed(context, '/');
              },
            ),
            Spacer(),
            Icon(FontAwesomeIcons.commentAlt),
            SizedBox(width: 20),
            Icon(FontAwesomeIcons.headphonesAlt),
            SizedBox(width: 20),
            Icon(FontAwesomeIcons.externalLinkAlt),
          ],
        ),
      ),
    );
  }
}
