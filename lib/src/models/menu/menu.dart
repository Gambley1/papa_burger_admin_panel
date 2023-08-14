import 'dart:convert' show json;

import 'package:equatable/equatable.dart' show Equatable;

class Menu extends Equatable {
  const Menu({
    this.category = '',
    this.items = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      category: json['category'] as String,
      items: List<dynamic>.from(
        json['items'] as List,
      ).map((e) => Item.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  const Menu.empty()
      : category = '',
        items = const [];
  final String category;
  final List<Item> items;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': category,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  Menu copyWith({
    String? category,
    List<Item>? items,
  }) {
    return Menu(
      category: category ?? this.category,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => <Object?>[category, items];
}

class Item extends Equatable {
  const Item({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.discount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      price: json['price'] as double,
      discount: json['discount'] as double,
    );
  }
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double discount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'discount': discount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        imageUrl,
        discount,
      ];
}
