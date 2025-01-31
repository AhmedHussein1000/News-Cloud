import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/widgets/search_news_articles_widgets/search_screen_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SearchScreenBody(),
      ),
    );
  }
}
