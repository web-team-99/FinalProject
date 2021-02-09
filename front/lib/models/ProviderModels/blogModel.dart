class BlogModel {
  int id;
  String title;
  String content;
  String updateTime;
  String createTime;
  String imageUrl;
  String owner;
  BlogModel({
    this.id,
    this.content,
    this.title,
    this.createTime,
    this.updateTime,
    this.owner,
    this.imageUrl,
  });
}
