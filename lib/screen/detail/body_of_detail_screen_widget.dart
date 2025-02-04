import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/screen/detail/menu_card_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "${restaurant.address}, ${restaurant.city}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate,
                      color: Colors.amber,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              restaurant.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox.square(dimension: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu Makanan",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox.square(dimension: 8),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: restaurant.menus.foods.map((food) {
                  return MenuCard(
                    image: 'assets/images/foods-illustration.png',
                    name: food.name
                  );
                }).toList(),
              ),
            ),
            const SizedBox.square(dimension: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menu Minuman",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox.square(dimension: 8),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: restaurant.menus.drinks.map((drink) {
                  return MenuCard(
                    image: 'assets/images/drinks-illustration.png',
                    name: drink.name
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
