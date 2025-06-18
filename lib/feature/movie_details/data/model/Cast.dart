class Cast {
  Cast({
      this.name, 
      this.characterName, 
      this.imdbCode,});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['imdb_code'] = imdbCode;
    return map;
  }

}