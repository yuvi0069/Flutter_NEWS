import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/model/article.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article_views.dart';

class Cateo extends StatefulWidget {
  final String cateogry;
  Cateo({this.cateogry});
  @override
  _CateoState createState() => _CateoState();
}

class _CateoState extends State<Cateo> {
  List<Article> articles = new List<Article>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    getCatNews();
  }

  getCatNews() async {
    CatNews newsClass = CatNews();
    await newsClass.getNews(widget.cateogry);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "YUVI",
                style: TextStyle(color: Colors.black),
              ),
              Text("NEWS", style: TextStyle(color: Colors.blue)),
            ],
          ),
          centerTitle: true,
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Blog(
                                image: articles[index].urlToImage,
                                desc: articles[index].description,
                                title: articles[index].title,
                                url: articles[index].url,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ));
  }
}

class Blog extends StatelessWidget {
  final String image, title, desc, url;
  Blog(
      {@required this.image,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogurl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(image)),
            SizedBox(
              height: 8,
            ),
            Text(title,
                style: TextStyle(
                    color: Color(0xFFB2039A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 4,
            ),
            Text(desc)
          ],
        ),
      ),
    );
  }
}
