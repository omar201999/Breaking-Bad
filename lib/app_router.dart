import 'package:breaking_bad/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/episode_details_screen.dart';
import 'package:breaking_bad/presentation/screens/episode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/character_screen.dart';

class AppRouter
{
  CharactersRepository? charactersRepository;
  CharactersCubit? charactersCubit;

  AppRouter(){
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository!);
  }

  Route? generateRouter(RouteSettings settings)
  {
    switch(settings.name)
    {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(charactersRepository!),
            child: CharactersScreen(),
        )
        );
      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => CharactersCubit(charactersRepository!),
                child: CharacterDetailsScreen(characterModel: character,),
            ),
        );
      case episodeScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (BuildContext context) => CharactersCubit(charactersRepository!),
          child: EpisodesScreen(),
        )
        );
      case episodeDetailsScreen:
        final episode = settings.arguments as EpisodeModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(charactersRepository!),
            child: EpisodesDetailsScreen(episodeModel:episode,),
          ),
        );
    }
  }
}
