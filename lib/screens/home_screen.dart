import 'package:flutter/material.dart';
import 'package:flutter_netflix_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_ui/data/data.dart';
import 'package:flutter_netflix_ui/widgets/content_header.dart';
import 'package:flutter_netflix_ui/widgets/content_list.dart';
import 'package:flutter_netflix_ui/widgets/custom_appbar.dart';
import 'package:flutter_netflix_ui/widgets/preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(
              scrollOffset: scrollOffset,
            );
          },
        ),
        preferredSize: Size(
          screenSize.width,
          50.0,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('myList'),
              title: 'My List',
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('original'),
                title: 'Netflix Originals',
                contentList: originals,
                isOriginal: true),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('trending'),
              title: 'Trending',
              contentList: trending,
            ),
          ),
        ],
      ),
    );
  }
}
