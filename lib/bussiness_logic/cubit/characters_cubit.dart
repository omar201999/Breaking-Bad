import 'package:bloc/bloc.dart';
import 'package:breaking_bad/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> characters = [];
  List<EpisodeModel> episodes = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharacterModel>? getAllCharacters() {
    charactersRepository
        .getAllCharacters()
        .then((characters) {
          emit(CharactersLoaded(characters));
          this.characters = characters;
    })
        .catchError((error) {
          emit(CharactersGetErrorState(error.toString()));
          print(error.toString());
    });
    return characters;
  }

  List<EpisodeModel>? getAllEpisode() {
    charactersRepository
        .getAllEpisodes()
        .then((episodes) {
          emit(EpisodeLoaded(episodes));
          this.episodes = episodes;
    })
        .catchError((error) {
          emit(EpisodesGetErrorState(error.toString()));
          print(error.toString());
    });
    return episodes;
  }
  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
      //print(quotes.toString());
    }).catchError((error) {
      emit(QuotesGetErrorState(error.toString()));
      print(error.toString());
    });
  }
}
