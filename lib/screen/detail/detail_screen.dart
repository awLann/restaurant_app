import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/bookmark_icon_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/bookmark_action_button_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyOfDetailScreenWidget(restaurant: restaurant),
            RestaurantDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox(),
          };
        },
      ),
      floatingActionButton: ChangeNotifierProvider(
        create: (context) => BookmarkIconProvider(),
        child: Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadedState(data: var restaurant) =>
              BookmarkActionButtonWidget(
                  restaurant: Restaurant(
                id: restaurant.id,
                name: restaurant.name,
                description: restaurant.description,
                pictureId: restaurant.pictureId,
                city: restaurant.city,
                rating: restaurant.rating,
              )),
            _ => const SizedBox()
          };
        }),
      ),
    );
  }
}
