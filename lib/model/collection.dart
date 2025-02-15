class Collection {
  final String id;
  final String name;
  final String description;
  final int itemCount;
  final DateTime createdAt;

  Collection({
    required this.id,
    required this.name,
    required this.description,
    required this.itemCount,
    required this.createdAt,
  });

  Collection copyWith({
    String? id,
    String? name,
    String? description,
    int? itemCount,
    DateTime? createdAt,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      itemCount: itemCount ?? this.itemCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}