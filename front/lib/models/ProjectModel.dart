class ProjectModel {
  String title;
  String description;
  String shortDescription;
  String id;
  String authorId;
  String freelanceId;
  String createdAt;
  bool isAssigned;
  double price;

  ProjectModel(
      {this.title,
      this.shortDescription,
      this.description,
      this.id,
      this.authorId,
      this.freelanceId,
      this.createdAt,
      this.isAssigned,
      this.price,
      });
      
}
