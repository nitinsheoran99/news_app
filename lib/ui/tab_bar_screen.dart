import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/model/news_info_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/news_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.category});

  final String category;

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final PagingController<int, Articles> pagingController = PagingController(firstPageKey: 1);
  NewsProvider? newsProvider;
  int pageSize = 10;

  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'Everything'),
    const Tab(text: 'Business'),
    const Tab(text: 'Entertainment'),
    const Tab(text: 'Health'),
    const Tab(text: 'Science'),
    const Tab(text: 'Sports'),
    const Tab(text: 'Technology'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Current Craze',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Everything'),
            Tab(text: 'Business'),
            Tab(text: 'Entertainment'),
            Tab(text: 'Health'),
            Tab(text: 'Science'),
            Tab(text: 'Sports'),
            Tab(text: 'Technology'),
          ],
          labelColor: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.file_copy),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person_outline),
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          NewsScreen(
            category: 'Everything',
          ),
          NewsScreen(
            category: 'Business',
          ),
          NewsScreen(
            category: 'Entertainment',
          ),
          NewsScreen(
            category:'Health',
          ),
          NewsScreen(
            category: 'Science',
          ),
          NewsScreen(
            category: 'Sports',
          ),
          NewsScreen(
            category: 'Technology',
          ),
        ],
      ),
    );
  }

}