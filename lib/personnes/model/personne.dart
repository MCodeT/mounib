import 'package:flutter/material.dart';

@immutable
class Personne {
  const Personne({
    required this.allergens,
    required this.userId,
    required this.name,
  });

  Personne.fromJson(Map<String, Object?> json)
      : this(
          allergens: (json['allergens']! as List).cast<String>(),
          userId: json['userId'] as String,
          name: json['name']! as String,
        );

  final String name;
  final String userId;
  final List<String> allergens;

  Map<String, Object?> toJson() {
    return {
      'allergens': allergens,
      'userId': userId,
      'name': name,
    };
  }
}
