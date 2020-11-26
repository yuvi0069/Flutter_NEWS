import 'package:flutter/material.dart';
import 'package:news/helper/dat.dart';
import 'package:news/model/catmodel.dart';
import 'package:news/model/article.dart';
import 'package:news/helper/news.dart';
import 'package:news/views/article_views.dart';
import 'package:news/views/cateogry.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Catmodel> cateogries = new List<Catmodel>();
  List<Article> articles = new List<Article>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    cateogries = getModel();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: cateogries.length,
                            itemBuilder: (context, index) {
                              return CateogryTile(
                                  imageurl: cateogries[index].cateogryimage,
                                  cateoname: cateogries[index].cateogryname);
                            })),
////BLOGS
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
                  ])),
            ),
    );
  }
}

class CateogryTile extends StatelessWidget {
  final String imageurl, cateoname;
  CateogryTile({this.imageurl, this.cateoname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Cateo(
                      cateogry: cateoname.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.black),
        child: Stack(
          children: [
            ClipRRect(
              child: Image(
                image: AssetImage(imageurl),
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Text(
                cateoname,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
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
