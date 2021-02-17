class CommentModel {
  String id;
  String authorId;
  String projectId;
  String writerId;
  String text;

  CommentModel(
      {this.id, this.authorId, this.projectId, this.writerId, this.text});
}
