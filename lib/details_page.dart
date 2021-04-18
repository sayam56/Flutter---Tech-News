import 'dart:ui';

import 'package:flutter/material.dart';
import './articleInfo.dart';
import 'package:background_app_bar/background_app_bar.dart';

class DetailsPage extends StatelessWidget {
  final String desc;

  DetailsPage(this.desc);

  @override
  Widget build(BuildContext context) {
    List<String> strings = desc.split("*");
    String description = strings.elementAt(0);
    String title = strings.elementAt(1);
    String imgURL = strings.elementAt(2);
    String url = strings.elementAt(3);
    return Scaffold(
        backgroundColor: Color(0xff212d3b),
        body: Center(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                centerTitle: true,
                expandedHeight: 300,
                //floating: true,
                pinned: true,
                //snap: true,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                flexibleSpace: BackgroundFlexibleSpaceBar(
                  title: Text(
                    title,
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.visible,
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(
                      left: 20.0, bottom: 20.0, right: 150),
                  background: ClipRect(
                    child: Container(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imgURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                  child: Center(
                      child: Stack(
                children: <Widget>[
                  ArticleInfo(description, url),
                ],
              ))),
            ],
          ),
        ));
  }
}
