import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider restaurantListProvider;
  
  setUp(() {
    mockApiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(mockApiServices);
  });
  
  group("restaurant list provider test", () {
    test('test initial status has been determined', () {
      expect(restaurantListProvider.resultState, isA<RestaurantListNoneState>());
    });
    
    test('test load data and return empty', () async {
      final emptyResponse = RestaurantListResponse(
        error: false,
        count: 0,
        message: "success",
        restaurants: [],
      );

      when(mockApiServices.getRestaurantList()).thenAnswer((_) async => emptyResponse);

      await restaurantListProvider.fetchRestaurantList();
      
      expect(restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final state = restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.isEmpty, true);
    });

    test('test load data and return data', () async {
      final dummyResponse = RestaurantListResponse(
        error: false,
        count: 1,
        message: "success",
        restaurants: [
          Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            pictureId: "14",
            city: "Medan",
            rating: 4.2,
          ),
        ],
      );

      when(mockApiServices.getRestaurantList()).thenAnswer((_) async => dummyResponse);

      await restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final state = restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.length, 1);
      expect(state.data[0].name, "Melting Pot");
      expect(state.data[0].pictureId, "14");
      expect(state.data[0].city, "Medan");
      expect(state.data[0].rating, 4.2);
    });
    
    test('test load data and return error', () async {
      when(mockApiServices.getRestaurantList()).thenThrow(Exception("Failed to load data"));
      
      await restaurantListProvider.fetchRestaurantList();
      
      expect(restaurantListProvider.resultState, isA<RestaurantListErrorState>());
      final state = restaurantListProvider.resultState as RestaurantListErrorState;
      expect(state.error, "Failed to load data");
    });
    
  });
}