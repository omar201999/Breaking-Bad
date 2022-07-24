import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';

class CharactersRepository{
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);


  Future <List<CharacterModel>> getAllCharacters()
  async{
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((characters) => CharacterModel.fromJson(characters)).toList();
  }
  Future <List<EpisodeModel>> getAllEpisodes()
  async{
    final episodes = await charactersWebServices.getAllEpisodes();
    return episodes.map((episodes) => EpisodeModel.fromJson(episodes)).toList();
  }


  Future <List<Quote>> getCharacterQuotes(String charName)
  async{
    final quotes  = await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }

}