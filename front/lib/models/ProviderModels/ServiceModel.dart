import 'dart:developer';

class ServiceModel {
  final String id;
  final String authorId;
  final String title;
  final String shortDescription;
  final String description;
  final String createdAt;
  final double price;

  ServiceModel(
      {this.id,
      this.authorId,
      this.title,
      this.shortDescription,
      this.description,
      this.price,
      this.createdAt});
  
}
