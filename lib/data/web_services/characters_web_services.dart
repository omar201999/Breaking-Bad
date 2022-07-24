import 'package:breaking_bad/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices
{
  Dio? dio;
  CharactersWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20sec
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  
  
  Future <List<dynamic>> getAllCharacters()
  async{
    try{
      Response response = await dio!.get('characters');
      print(response.data.toString());
      return response.data;
    }catch(error){
      print(error.toString());
      return [];
    }
  }

  Future <List<dynamic>> getAllEpisodes()
  async{
    try{
      Response response = await dio!.get('episodes');
      print(response.data.toString());
      return response.data;
    }catch(error){
      print(error.toString());
      return [];
    }
  }


  Future <List<dynamic>> getCharacterQuotes(String charName)
  async{
    try{
      Response response = await dio!.get('quote',queryParameters: {'author' : charName});
      print(response.data.toString());
      return response.data;
    }catch(error){
      print(error.toString());
      return [];
    }
  }
  
}