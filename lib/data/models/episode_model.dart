class EpisodeModel
{
  int? episodeId;
  String? title;
  String? season;
  String? episode;
  String? series;
  String? showDate;
  List<dynamic>? charactersOfEpisode;

  EpisodeModel.fromJson(Map<String,dynamic> json)
  {
    episodeId=json['episode_id'];
    title=json['title'];
    season=json['season'];
    episode=json['episode'];
    showDate=json['air_date'];
    series=json['series'];
    charactersOfEpisode=json['characters'];
  }
}