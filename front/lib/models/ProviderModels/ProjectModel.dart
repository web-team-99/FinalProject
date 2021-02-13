class ProjectModel {
  final String title;
  final String description;
  final String shortDescription;
  final String id;
  final String authorId;
  final String freelanceId;
  final String createdAt;
  final bool isAssigned;


  ProjectModel(
      {this.title,
      this.shortDescription,
      this.description,
      this.id,
      this.authorId,
      this.freelanceId,
      this.createdAt,
      this.isAssigned
      });
}
