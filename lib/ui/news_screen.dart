import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/model/news_info_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/news_details_screen.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    required this.category,
    super.key,
  });

  final String category;

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final PagingController<int, Articles> _pagingController =
  PagingController(firstPageKey: 1);

  NewsProvider? newsProvider;
  int pageSize = 20;

  Future paginationListener() async {
    _pagingController.addPageRequestListener((pageKey) {
      fetchNews(pageKey);
    });
  }

  @override
  void initState() {
    super.initState();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    paginationListener();
  }

  Future<void> fetchNews(int pageKey) async {
    await newsProvider?.fetchNews(
      pageKey: pageKey,
      query: widget.category,
    );
    final isLastPage = newsProvider!.articles?.isEmpty ?? false;
    if (isLastPage) {
      _pagingController.appendLastPage(newsProvider!.articles!);
    } else {
      pageKey++;
      _pagingController.appendPage(
          newsProvider!.articles?.sublist(0, pageSize) ?? [], pageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<NewsProvider>(builder: ((context, newsProvider, child) {
          return CustomScrollView(
            slivers: [
              PagedSliverList<int, Articles>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Articles>(
                  itemBuilder: (context, article, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        ListTile(
                          title: Text(
                            article.title ?? '',
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            article.description ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      article.urlToImage.toString()
                                  ),
                                )),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return  NewsDetailScreen(articles: article,);
                            }));
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        })));
  }
}