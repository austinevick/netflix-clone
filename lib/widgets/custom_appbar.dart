import 'package:flutter/material.dart';

import 'package:flutter_netflix_ui/assets.dart';
import 'package:flutter_netflix_ui/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomAppBar({
    Key key,
    this.scrollOffset,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 24,
        ),
        color: Colors.red.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble(),
        ),
        child: Responsive(
          mobile: CustomAppBarMobile(),
          desktop: CustomAppBarDesktop(),
        ));
  }
}

class CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(
            Assets.netflixLogo0,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppBarButton(
                  title: 'TV Shows',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'Movies',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'My List',
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(
            Assets.netflixLogo1,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppBarButton(
                  title: 'Home',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'TV Shows',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'Movies',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'Latest',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'My List',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.search,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                AppBarButton(
                  title: 'KIDS',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'DVD',
                  onTap: () {},
                ),
                AppBarButton(
                  title: 'Movies',
                  onTap: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.card_giftcard,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.notifications,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const AppBarButton({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
