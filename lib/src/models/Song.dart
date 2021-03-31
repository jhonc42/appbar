import 'dart:convert';

Song hadesResponseFromJson(String str) => Song.fromJson(json.decode(str));

String hadesResponseToJson(Song data) => json.encode(data.toJson());

class Song {
  Song({
    this.name,
    this.type,
  });

  String name;
  int type;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        name: json["Name"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Type": type,
      };
}
