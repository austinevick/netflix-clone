import 'package:flutter/material.dart';
import 'package:flutter_netflix_ui/models/content_model.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginal;

  const ContentList({
    Key key,
    this.title,
    this.contentList,
    this.isOriginal = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
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
            height: isOriginal ? 500 : 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: contentList.length,
                itemBuilder: (context, index) {
                  final Content content = contentList[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: isOriginal ? 400 : 200,
                      width: isOriginal ? 200 : 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        content.imageUrl,
                      ))),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
