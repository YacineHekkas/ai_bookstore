import 'package:flutter/material.dart';
import '../model/collection.dart';

class CollectionsProvider with ChangeNotifier {
  final List<Collection> _collections = [
    Collection(
      id: '1',
      name: 'my Save',
      description: 'small description about the section is general may take',
      itemCount: 12,
      createdAt: DateTime.now(),
    ),
    Collection(
      id: '2',
      name: 'action',
      description: 'small description about the section is general may take',
      itemCount: 2,
      createdAt: DateTime.now(),
    ),
    Collection(
      id: '3',
      name: 'romance',
      description: 'small description about the section is general may take',
      itemCount: 2,
      createdAt: DateTime.now(),
    ),
    Collection(
      id: '4',
      name: 'check later',
      description: 'small description about the section is general may take',
      itemCount: 8,
      createdAt: DateTime.now(),
    ),
    Collection(
      id: '5',
      name: 'Popular',
      description: 'small description about the section is general may take',
      itemCount: 8,
      createdAt: DateTime.now(),
    ),
  ];

  List<Collection> get collections => [..._collections];

  Future<void> addCollection(String name, String description) async {
    final collection = Collection(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      itemCount: 0,
      createdAt: DateTime.now(),
    );

    _collections.add(collection);
    notifyListeners();
    // TODO: Implement API call to add collection
  }

  Future<void> updateCollection(String id, String name, String description) async {
    final index = _collections.indexWhere((collection) => collection.id == id);
    if (index >= 0) {
      _collections[index] = _collections[index].copyWith(
        name: name,
        description: description,
      );
      notifyListeners();
      // TODO: Implement API call to update collection
    }
  }

  Future<void> deleteCollection(String id) async {
    _collections.removeWhere((collection) => collection.id == id);
    notifyListeners();
    // TODO: Implement API call to delete collection
  }
}