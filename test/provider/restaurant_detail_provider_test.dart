import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late RestaurantDetailProvider restaurantDetailProvider;

  setUp(() {
    mockApiServices = MockApiServices();
    restaurantDetailProvider = RestaurantDetailProvider(mockApiServices);
  });

  group("restaurant detail provider test", () {
    test('test initial status has been determined', () {
      expect(restaurantDetailProvider.resultState, isA<RestaurantDetailNoneState>());
    });

    test('test load data and return error', () async {
      when(mockApiServices.getRestaurantDetail("id")).thenThrow(Exception("Failed to load data"));

      await restaurantDetailProvider.fetchRestaurantDetail("id");

      expect(restaurantDetailProvider.resultState, isA<RestaurantDetailErrorState>());
      final state = restaurantDetailProvider.resultState as RestaurantDetailErrorState;
      expect(state.error, "Failed to load data");
    });

  });
}