import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:flutter/material.dart';

class EpisodeItem extends StatelessWidget {
  EpisodeModel episodeModel;


  EpisodeItem({required this.episodeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, episodeDetailsScreen , arguments: episodeModel),
        child: GridTile(
          child: Hero(
            tag: episodeModel.episodeId!,
            child: Container(
              color: MyColors.myGrey,
              child: episodeModel.showDate!.isNotEmpty ? Center(
                  child: Text(
                      episodeModel.title!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: MyColors.myWhite,
                    ),
                    textAlign: TextAlign.center,

                  ),
              ) : Image.asset('assets/images/groot.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              'Season ${episodeModel.season!} of ${episodeModel.series}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
