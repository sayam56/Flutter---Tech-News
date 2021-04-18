import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ArticleInfo extends StatelessWidget {
  final String desc;
  final String url;
  ArticleInfo(this.desc, this.url);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                desc,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                  color: Color(0xFF8F979E),
                  child: Text('Read More...'),
                  onPressed: () {
                    _launchURL(url);
                  }),
            ]),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Couldn\'n Launch $url';
  }
}
