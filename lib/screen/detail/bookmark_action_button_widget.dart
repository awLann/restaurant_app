import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/bookmark_icon_provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';

class BookmarkActionButtonWidget extends StatefulWidget {
  final Restaurant restaurant;

  const BookmarkActionButtonWidget({super.key, required this.restaurant});

  @override
  State<BookmarkActionButtonWidget> createState() =>
      _BookmarkActionButtonWidgetState();
}

class _BookmarkActionButtonWidgetState
    extends State<BookmarkActionButtonWidget> {
  @override
  void initState() {
    super.initState();

    final bookmarkIconProvider = context.read<BookmarkIconProvider>();
    final bookmarkDatabaseProvider = context.read<LocalDatabaseProvider>();

    Future.microtask(() async {
      await bookmarkDatabaseProvider.loadRestaurantById(widget.restaurant.id);
      final value = bookmarkDatabaseProvider.restaurant == null
          ? false
          : bookmarkDatabaseProvider.restaurant!.id == widget.restaurant.id;
      bookmarkIconProvider.isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final bookmarkDatabaseProvider = context.read<LocalDatabaseProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (isBookmarked) {
          await bookmarkDatabaseProvider
              .removeRestaurantById(widget.restaurant.id);
        } else {
          await bookmarkDatabaseProvider.saveRestaurantValue(widget.restaurant);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
        bookmarkDatabaseProvider.loadAllRestaurant();
      },
      child: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
