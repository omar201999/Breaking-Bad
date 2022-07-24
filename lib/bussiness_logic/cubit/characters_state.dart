
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:breaking_bad/data/models/quote.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}


class CharactersGetErrorState extends CharactersState {
  final String error;
  CharactersGetErrorState(this.error);
}
class EpisodesGetErrorState extends CharactersState {
  final String error;
  EpisodesGetErrorState(this.error);
}
class QuotesGetErrorState extends CharactersState {
  final String error;
  QuotesGetErrorState(this.error);
}

class CharactersLoaded extends CharactersState
{
  final List<CharacterModel> characters;

  CharactersLoaded(this.characters);
}

class EpisodeLoaded extends CharactersState
{
  final List<EpisodeModel> episodes;

  EpisodeLoaded(this.episodes);
}

class QuotesLoaded extends CharactersState {
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
