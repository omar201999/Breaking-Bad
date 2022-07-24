import 'package:breaking_bad/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/episode_model.dart';
import 'package:breaking_bad/presentation/widgets/episode_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen>
{
  List<EpisodeModel>? allEpisodes;
  List<EpisodeModel>? searchForEpisodes;
  bool isSearching = false;
  TextEditingController searchTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllEpisode();
  }

  Widget buildSearchFileld()
  {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a episode....',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey,fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey,fontSize: 18),
      onChanged: (searchedEpisode)
      {
        addSearchedFOrItemsToSearchedList(searchedEpisode);
      },
    );

  }

  void addSearchedFOrItemsToSearchedList(String searchedEpisode )
  {
    searchForEpisodes = allEpisodes!.where((element) => element.title!.toLowerCase().startsWith(searchedEpisode)).toList();
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
          if (state is EpisodeLoaded) {
            allEpisodes = (state).episodes;
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
        itemCount: searchTextController.text.isEmpty ? allEpisodes?.length : searchForEpisodes!.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return EpisodeItem(
            episodeModel: searchTextController.text.isEmpty ? allEpisodes![index] : searchForEpisodes![index],
          );
        });
  }
  Widget _buildAppBarTitle() {
    return Text(
      'Episodes',
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
