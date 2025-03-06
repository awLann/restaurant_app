import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxHeight: 100,
                    minHeight: 100,
                    maxWidth: 140,
                    minWidth: 140),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox.square(dimension: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      const Icon(Icons.pin_drop),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rate,
                        color: Colors.amber,
                      ),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
