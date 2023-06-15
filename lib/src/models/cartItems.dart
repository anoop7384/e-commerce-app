class CartItem {
  int? id;
  String? title;
  var price;
  int? quantity;
  String? description;
  String? category;
  String? image;

  CartItem({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.quantity,
  });
}
