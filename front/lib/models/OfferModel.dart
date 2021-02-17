class OfferModel {
  String id;
  String authorId;
  String projectId;
  String freelancerId;
  int price;
  String description;
  int period;

  OfferModel(
      {this.id,
      this.authorId,
      this.projectId,
      this.freelancerId,
      this.price,
      this.description,
      this.period});
}
