class BurgerModel {
  final String id;
  final String title;
  final String image;
  final double price;

  BurgerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  String toMoney() {
    return r'R$ ' + price.toStringAsFixed(2);
  }
}
