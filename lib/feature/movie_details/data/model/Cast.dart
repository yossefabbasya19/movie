class Cast {
  Cast({
      this.name, 
      this.characterName, 
      this.imdbCode,
    this.actorImage
  });

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    imdbCode = json['imdb_code'];
    actorImage = json["url_small_image"];
  }
  String? name;
  String? characterName;
  String? imdbCode;
  String? actorImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['imdb_code'] = imdbCode;
    map['url_small_image'] = actorImage;
    return map;
  }

}