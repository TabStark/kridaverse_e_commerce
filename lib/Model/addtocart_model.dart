class AddtoCartJson {
  AddtoCartJson({
    required this.img,
    required this.price,
    required this.discription,
    required this.name,
    required this.qty,
  });
  late final String img;
  late final String price;
  late final String name;
  late final List<dynamic> discription;
  late final int qty;

  AddtoCartJson.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    price = json['price'];
    name = json['name'];
    discription = List.castFrom(json['discription'] ?? []);
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['img'] = img;
    _data['price'] = price;
    _data['name'] = name;
    _data['discription'] = discription;
    _data['qty'] = qty;
    return _data;
  }
}
