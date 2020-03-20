import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;

class SingleArticle extends StatefulWidget {
  final dynamic article;

  SingleArticle(this.article, {Key key}) : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final articleVideo = widget.article.video;
    String youtubeUrl = "";
    String dailymotionUrl = "";
    if (articleVideo.contains("youtube")) {
      youtubeUrl = articleVideo.split('?v=')[1];
    }
    if (articleVideo.contains("dailymotion")) {
      dailymotionUrl = articleVideo.split("/video/")[1];
    }

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0)),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.overlay),
                          child: articleVideo != ""
                              ? articleVideo.contains("youtube")
                                  ? Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0,
                                          MediaQuery.of(context).padding.top,
                                          0,
                                          0),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: HtmlWidget(
                                        """
                                      <iframe src="https://www.youtube.com/embed/$youtubeUrl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                      """,
                                        webView: true,
                                        bodyPadding: EdgeInsets.all(0),
                                      ),
                                    )
                                  : articleVideo.contains("dailymotion")
                                      ? Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              MediaQuery.of(context)
                                                  .padding
                                                  .top,
                                              0,
                                              0),
                                          decoration: BoxDecoration(
                                              color: Colors.black),
                                          child: HtmlWidget(
                                            """
                                      <iframe frameborder="0"
                                      src="https://www.dailymotion.com/embed/video/$dailymotionUrl?autoplay=1&mute=1"
                                      allowfullscreen allow="autoplay">
                                      </iframe>
                                      """,
                                            webView: true,
                                            bodyPadding: EdgeInsets.all(0),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              MediaQuery.of(context)
                                                  .padding
                                                  .top,
                                              0,
                                              0),
                                          decoration: BoxDecoration(
                                              color: Colors.black),
                                          child: HtmlWidget(
                                            """
                                      <video autoplay="" playsinline="" controls>
                                      <source type="video/mp4" src="$articleVideo">
                                      </video>
                                      """,
                                            webView: true,
                                            bodyPadding: EdgeInsets.all(0),
                                          ),
                                        )
                              : Image.network(
                                  article.image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Html(
                          data: "<h1>" + article.title + "</h1>",
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "h1":
                                  return Theme.of(context)
                                      .textTheme
                                      .title
                                      .merge(TextStyle(fontSize: 20));
                              }
                            }
                            return baseStyle;
                          }),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE3E3E3),
                            borderRadius: BorderRadius.circular(3)),
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        margin: EdgeInsets.all(16),
                        child: Text(
                          article.category,
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(''),
                          // ),
                          title: Text(
                            "By " + article.author,
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: Text(
                            article.date,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Html(
                          data: "<div>" + article.content + "</div>",
                          padding: EdgeInsets.fromLTRB(16, 36, 16, 50),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "div":
                                  return baseStyle
                                      .merge(Theme.of(context).textTheme.body1);
                              }
                            }
                            return baseStyle;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
