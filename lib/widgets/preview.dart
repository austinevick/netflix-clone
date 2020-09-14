import 'package:flutter/material.dart';

import 'package:flutter_netflix_ui/models/content_model.dart';

class Previews extends StatelessWidget {
  final List<Content> contentList;
  final String title;
  const Previews({
    Key key,
    this.contentList,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 165,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              itemCount: contentList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                final Content content = contentList[i];
                return GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: content.color, width: 4.0),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black38, BlendMode.darken),
                                image: AssetImage(
                                  content.imageUrl,
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: 60,
                            child: Image.asset(
                              content.titleImageUrl,
                            ),
                          ))
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
