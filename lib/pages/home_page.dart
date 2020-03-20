import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:module_1/models/articles.dart';
import 'package:module_1/pages/single_article.dart';
import 'package:module_1/widgets/article_box.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var a1 = Article(
      'macbook pro 2019',
      'The 13-inch MacBook Pro 2019 has arguably received the biggest change out of the three MacBook revisions Apple rolled out in 2019. After killing off the MacBook 12-inch, the manufacturer released 2019 models of the MacBook Pro 13-inch, MacBook Pro 15-inch and the MacBook Air, and the smaller MacBook Pro has come out the winner.',
      '11/5/2015',
      'https://i.ytimg.com/vi/V7pce4nrR4c/maxresdefault.jpg',
      'https://www.youtube.com/watch?v=9EIWKJ5HSO8',
      'tech',
      'unbox theraby');

  var a2 = Article(
      'One plus 7 pro',
      'OnePlus 7 Pro smartphone runs on Android v9.0 (Pie) operating system. The phone is powered by Octa core (2.84 GHz, Single core, Kryo 485 + 2.42 GHz, Tri core, Kryo 485 + 1.8 GHz, Quad core, Kryo 485) processor. It runs on the Qualcomm Snapdragon 855 Chipset. It has 6 GB RAM and 128 GB internal storage.',
      '5/5/2018',
      'https://cdn.opstatics.com/store/20170907/assets/images/events/2019/04/18821/highlight/kv-static-m.jpg?20200318125245',
      'https://www.youtube.com/watch?v=oMI1zFAh0S0&t=368s',
      'tech',
      'unbox theraby');

  var a3 = Article(
      'Ipad pro 2019',
      'Apple today announced its most advanced iPad Pro. Now with the A12Z Bionic chip, iPad Pro is faster and more powerful than most Windows PC laptops. The new iPad Pro adds an Ultra Wide camera, studio-quality mics and a breakthrough LiDAR Scanner that delivers cutting-edge depth-sensing capabilities, opening up more pro workflows and supporting pro photo and video apps. The LiDAR Scanner, along with pro cameras, motion sensors, pro performance, pro audio, the stunning Liquid Retina display and powerful apps, extends the lead of iPad Pro as the world’s best device for augmented reality (AR). The new iPad Pro is available to order starting today on apple.com.',
      '8/8/2020',
      'https://www.apple.com/v/ipad-pro/x/images/meta/og__ek1oqpcwtymq_overview.png?201909071257',
      'https://www.youtube.com/watch?v=SK5ElzvKie8',
      'tech',
      'unbox theraby'
      );

  var a4 = Article(
  'Covid-19',
  'Coronaviruses (CoV) are a large family of viruses that cause illness ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS-CoV) and Severe Acute Respiratory Syndrome (SARS-CoV)' ,
  '9/9/2019' ,
  'https://www.carolstream.org/Home/ShowPublishedImage/2097/637187449130130000' ,
  'https://www.youtube.com/watch?v=71RnbszZ9Lw' ,
  'medicine',
  'World Health Organization');

  var a5 = Article(
  'Fasting',
  'Fasting is the willful refrainment from eating for a period of time. In a physiological context, fasting may refer to the metabolic status of a person who has not eaten overnight, or to the metabolic state achieved after complete digestion and absorption of a meal. Several metabolic adjustments occur during fasting. Some diagnostic tests are used to determine a fasting state. For example, a person is assumed to be fasting once 8–12 hours have elapsed since the last meal. Metabolic changes of the fasting state begin after absorption of a meal (typically 3–5 hours after eating).' ,
  '5/5/2012' ,
  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRIJayPF4WogDpvQOyebYC-dm-3xtrAEL2C2fYDjxypQo6XnquN' ,
  'https://www.youtube.com/watch?v=XeSL_jzMedU' ,
  'medicine' ,
  'Wikipedia');

  var V = 'https://www.youtube.com/watch?v=b5ociE192f0';

  List<dynamic> _articles = new List<dynamic>();
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _articles.add(a1);
    _articles.add(a2);
    _articles.add(a3);
    _articles.add(a4);
    _articles.add(a5);
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Image(
              image: AssetImage('assets/icon.jpg'),
              height: 45,
            ),
            title: Text(widget.title),
            elevation: 5,
            //backgroundColor: Colors.black,
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: _controller,
              child: Column(
                
                children: <Widget>[video(V), articles(_articles)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget video(String videoURL) {
    var youtubeUrl, dailymotionUrl;
    if (videoURL.contains("youtube")) {
      youtubeUrl = videoURL.split('?v=')[1];
    }
    if (videoURL.contains("dailymotion")) {
      dailymotionUrl = videoURL.split("/video/")[1];
    }
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0)),
        child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.overlay),
            child: videoURL != ""
                ? videoURL.contains("youtube")
                    ? Container(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, 0, 0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: HtmlWidget(
                          """
                                      <iframe src="https://www.youtube.com/embed/$youtubeUrl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                      """,
                          webView: true,
                          bodyPadding: EdgeInsets.all(0),
                        ),
                      )
                    : videoURL.contains("dailymotion")
                        ? Container(
                            padding: EdgeInsets.fromLTRB(
                                0, MediaQuery.of(context).padding.top, 0, 0),
                            decoration: BoxDecoration(color: Colors.black),
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
                                0, MediaQuery.of(context).padding.top, 0, 0),
                            decoration: BoxDecoration(color: Colors.black),
                            child: HtmlWidget(
                              """
                                      <video autoplay="" playsinline="" controls>
                                      <source type="video/mp4" src="$videoURL">
                                      </video>
                                      """,
                              webView: true,
                              bodyPadding: EdgeInsets.all(0),
                            ),
                          )
                : Text('')),
      ),
    );
  }

  Widget articles(List<dynamic> articles) {
    // print(articles.length);
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Column(children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleArticle(articles[index]),
                      ),
                    );
                  },
                  child: articleBox(context, articles[index]),
                )
              ])
            ],
          );
        },
      ),
    );
  }
}
