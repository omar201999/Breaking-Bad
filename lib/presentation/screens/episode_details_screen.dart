import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesDetailsScreen extends StatelessWidget
{
  final EpisodeModel episodeModel;

  EpisodesDetailsScreen({required this.episodeModel});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          episodeModel.title!,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: episodeModel.episodeId!,
          child: Image.asset(
            'assets/images/logo_3.png',
            fit: BoxFit.cover,
            //height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state)
  {
    if(state is EpisodeLoaded)
    {
      return  displayRandomQuoteOrEmptySpace(state);
    }
    else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state)
  {
    //print(quotes[1]);

      //int randomQuoteIndex = Random().nextInt(episode.length - 1);
      return
        Center(
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows:
              [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts:
              [
                RotateAnimatedText(episodeModel.charactersOfEpisode![0]),
                RotateAnimatedText(episodeModel.charactersOfEpisode![1]),
                RotateAnimatedText(episodeModel.charactersOfEpisode![2]),
                RotateAnimatedText(episodeModel.charactersOfEpisode![3]),
                RotateAnimatedText(episodeModel.charactersOfEpisode![4]),
              ],
              isRepeatingAnimation: true,

            ),
          ),
        );
       /* Row(
          mainAxisSize: MainAxisSize.min,
          children:[

             Text(
              'Characters : ',
              style: TextStyle(color:MyColors.myWhite,fontSize: 25,fontWeight: FontWeight.bold),

            ),
            const SizedBox(width: 20.0, ),

          ],
        )*/;/*Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows:
              [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts:
              [
                FlickerAnimatedText(episode[episodeModel.episodeId].charactersOfEpisode),
              ],
            )
        ),
      );*/

  }
  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllEpisode();
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Title : ', episodeModel.title!),
                    buildDivider(310),
                    characterInfo(
                        'Season : ', episodeModel.season!),
                    buildDivider(280),
                    characterInfo('Episode : ', episodeModel.episode!),
                    buildDivider(280),
                    characterInfo(
                        'Show Date : ', episodeModel.showDate!),
                    buildDivider(260),
                    characterInfo(
                        'Series : ', episodeModel.series!),
                    buildDivider(260),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit,CharactersState>(
                      builder:(context,state)
                      {
                        return checkIfQuotesAreLoaded(state);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
