class BurgerEntity {
  final String id;
  final String title;
  final String image;
  final double price;

  BurgerEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  String toMoney() {
    return r'R$ ' + price.toStringAsFixed(2);
  }

  BurgerEntity copyWith({
    String? id,
    String? title,
    String? image,
    double? price,
  }) {
    return BurgerEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }
}
