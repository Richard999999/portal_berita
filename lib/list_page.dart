import 'package:portal_berita/article.dart';
import 'package:portal_berita/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:portal_berita/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder<String>(
          future:
              DefaultAssetBundle.of(context).loadString('assets/articles.json'),
          builder: (context, snapshot) {
            final List<Article> articles = parseArticles(snapshot.data);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleItem(context, articles[index]);
              },
            );
          }),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
  return Material(
    child: ListTile(
      leading: Hero(
        tag: article.urlToImage,
        child: Image.network(
          article.urlToImage,
          width: 100,
        ),

        // onTap: () {
        //   Navigator.pushNamed(context, ArticleDetailPage.routeName,
        //       arguments: article);
        // },
        // contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // leading: Image.network(
        //   article.urlToImage,
        //   width: 100,
        // ),
        // title: Text(article.title),
        // subtitle: Text(article.author),
      ),
    ),
  );
}

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const ArticleWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}
