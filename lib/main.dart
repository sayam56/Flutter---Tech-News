import 'package:flutter/material.dart';
import 'package:json_cache/api_manager.dart';
import 'package:json_cache/models/techNews.dart';
import './route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Welcome> _articles;

  @override
  void initState() {
    _articles = ApiManager().getNews();
    //this returns the articles inside the json object
    //keep in mind that this data comes in the future

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212d3b),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: SafeArea(
            child: AppBar(
          centerTitle: true,
          title: Text('Tech News'),
          backgroundColor: Colors.transparent,
        )),
      ),
      body: Container(
        child: FutureBuilder<Welcome>(
          future: _articles,
          builder: (context, snapshot) {
            //snapshot is the latest data fetched from the server that is being loaded
            //this will build the listview and the container IF data arrives from the backend
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  //so the latest data from backend.data.articles ->becasue each time it is sent with a status code
                  itemBuilder: (context, index) {
                    //itembuild receives a context of the latest fetched item with its index
                    var article = snapshot.data.articles[index];
                    //so here we pick that particular index's data that is the new article, and with that var we will access it
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/details',
                            arguments: article.description+'*'+article.title+'*'+article.urlToImage+'*'+article.url);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: EdgeInsets.all(8),
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    article.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    article.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Color(0xFF8F979E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Fetching News',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
