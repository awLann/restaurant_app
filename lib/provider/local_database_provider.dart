import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> saveRestaurantValue(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save data";
      } else {
        _message = "Data is saved";
      }
    } catch (e) {
      _message = "Data is saved";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load all data";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove data";
      notifyListeners();
    }
  }
}
