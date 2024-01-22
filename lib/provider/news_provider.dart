
import 'package:flutter/foundation.dart';
import 'package:news_app/model/news_info_model.dart';
import 'package:news_app/service/news_service.dart';

class NewsProvider extends ChangeNotifier{
  List<Articles>? articles;
  String? errorMsg;
  Future fetchNews({required int pageKey, required String query}) async {
    errorMsg = null;
    try{
      articles = await NewsService.fetchNews(pageKey: pageKey, query: query);
    }
    catch(e){
      if (kDebugMode) {
        print(e);
      }
      errorMsg = e.toString();
    }
    notifyListeners();
  }
}