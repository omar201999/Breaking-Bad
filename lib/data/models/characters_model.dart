class CharacterModel {
  int? charId;
  String? name;
  String? birthday;
  List<dynamic>? jobs;
  String? image;
  String? statusIfDeadOrAlive;
  String? nickname;
  List<dynamic>? appearanceOfSeason;
  String? actorName;
  String? categoryForTwoSeries;
  List<dynamic>? betterCallSaulAppearance;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    jobs = json['occupation'].cast<String>();
    image = json['img'];
    statusIfDeadOrAlive = json['status'];
    nickname = json['nickname'];
    appearanceOfSeason = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
