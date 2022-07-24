import 'package:breaking_bad/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen>
{
  List<CharacterModel>? allCharacters;
  List<CharacterModel>? searchForCharacters;
  bool isSearching = false;
  TextEditingController searchTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
     BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildSearchFileld()
  {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey,fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey,fontSize: 18),
      onChanged: (searchedCharacter)
      {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );

  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter )
  {
    searchForCharacters = allCharacters!.where((element) => element.name!.toLowerCase().startsWith(searchedCharacter)).toList();
    setState(() {

    });
  }

  List<Widget> buildAppBarActions()
  {
    if(isSearching)
    {
      return [
        IconButton(
          onPressed: (){
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else
      {
        return
          [
            IconButton(
              onPressed:startSearch,
              icon: Icon(
                Icons.search,
                color: MyColors.myGrey,
              ),
            ),

          ];
      }
  }

  void startSearch()
  {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove:stopSearching ));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching()
  {
    clearSearch();
    setState(() {
      isSearching = false;
    });

  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }
  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: searchTextController.text.isEmpty ? allCharacters?.length : searchForCharacters!.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(
            characterModel: searchTextController.text.isEmpty ? allCharacters![index] : searchForCharacters![index],
          );
        });
  }
  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }


  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: isSearching ? BackButton(color: MyColors.myGrey,) : Container(),

        title: isSearching ? buildSearchFileld() : _buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body:  OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
