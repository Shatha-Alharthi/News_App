import 'package:dio/dio.dart';
import 'package:news_app/data/models/get_news_model.dart';

class GetNewsRepo {
  final dio = Dio();

  Future<GetNewsModel?> getNews() async {
    Response response;
    response = await dio.get(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=51cd2366dade4bf3bd88f2bbc54e2924");

    if (response.statusCode == 200) {
      GetNewsModel myNews = GetNewsModel.fromJson(response.data);

      return myNews;
    } else {
      return null;
    }
  }
}

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=51cd2366dade4bf3bd88f2bbc54e2924