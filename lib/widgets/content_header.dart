import 'package:flutter/material.dart';

import 'package:flutter_netflix_ui/models/content_model.dart';
import 'package:flutter_netflix_ui/widgets/responsive.dart';
import 'package:video_player/video_player.dart';

import 'vertical_icon_button.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({
    Key key,
    this.featuredContent,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: ContentHeaderMobile(
        featuredContent: featuredContent,
      ),
      desktop: ContentHeaderDesktop(
        featuredContent: featuredContent,
      ),
    );
  }
}

class ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const ContentHeaderMobile({
    Key key,
    this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    featuredContent.imageUrl,
                  ))),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent])),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(
              featuredContent.titleImageUrl,
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () {},
                ),
                PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'info',
                  onTap: () {},
                )
              ],
            ))
      ],
    );
  }
}

class ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const ContentHeaderDesktop({
    Key key,
    this.featuredContent,
  }) : super(key: key);

  @override
  _ContentHeaderDesktopState createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<ContentHeaderDesktop> {
  VideoPlayerController videoPlayerController;
  bool isMuted = true;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
      widget.featuredContent.videoUrl,
    )
      ..initialize().then((_) => setState(() {}))
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => videoPlayerController.value.isPlaying
          ? videoPlayerController.pause()
          : videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      widget.featuredContent.imageUrl,
                    ))),
          ),
          Container(
            height: 500,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent])),
          ),
          Positioned(
            bottom: 110,
            child: SizedBox(
              width: 250,
              child: Image.asset(
                widget.featuredContent.titleImageUrl,
              ),
            ),
          ),
          Positioned(
              left: 60,
              right: 60,
              bottom: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Image.asset(
                      widget.featuredContent.titleImageUrl,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.featuredContent.description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.black,
                            offset: Offset(
                              2,
                              4,
                            ),
                          )
                        ]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 5, 20, 5),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 30,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
