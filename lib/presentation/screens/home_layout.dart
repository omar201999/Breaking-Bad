import 'package:breaking_bad/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/character_screen.dart';
import 'package:breaking_bad/presentation/screens/episode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> bodyScreen = [
     CharactersScreen(),
     EpisodesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CharactersCubit(CharactersRepository(CharactersWebServices())),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColors.myYellow,
          unselectedItemColor:  Colors.black54,
          backgroundColor: MyColors.myGrey,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index)
          {
            setState(() {
              currentIndex = index;
            });
          },
          items:
          [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Characters',//'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  //episodes
                  Icons.menu
              ),
              label:  'Episodes',
            ),



          ],
        ),
        body: bodyScreen[currentIndex],
      ),
    );
  }
}
