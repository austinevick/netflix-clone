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
      ..setVolume(0)
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
          AspectRatio(
            aspectRatio: videoPlayerController.value.initialized
                ? videoPlayerController.value.aspectRatio
                : 2.344,
            child: videoPlayerController.value.initialized
                ? VideoPlayer(videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          AspectRatio(
            aspectRatio: videoPlayerController.value.initialized
                ? videoPlayerController.value.aspectRatio
                : 2.344,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent])),
            ),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      PlayButton(),
                      const SizedBox(
                        width: 18,
                      ),
                      FlatButton.icon(
                          padding: const EdgeInsets.fromLTRB(25, 10, 30, 10),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_outline,
                            size: 30,
                          ),
                          label: Text('More Info',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      if (videoPlayerController.value.initialized)
                        IconButton(
                          iconSize: 30,
                          color: Colors.white,
                          icon: Icon(
                              isMuted ? Icons.volume_off : Icons.volume_up),
                          onPressed: () => setState(() {
                            isMuted
                                ? videoPlayerController.setVolume(100)
                                : videoPlayerController.setVolume(0);
                            isMuted = videoPlayerController.value.volume == 0;
                          }),
                        )
                    ],
                  )
                ],
              )),
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
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(15, 5, 20, 5)
          : const EdgeInsets.fromLTRB(25, 10, 30, 10),
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
