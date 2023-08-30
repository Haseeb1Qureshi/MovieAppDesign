import 'dart:convert';
/// id : 1
/// name : "Iphone 14 pro"
/// desc : "Apple Iphone 14th generation"
/// price : 999
/// image : "https://stall.pk/wp-content/uploads/2022/10/Apple-iphone-14-pro-price-in-pakistan-stall.pk_.jpg"

CatalogModels catalogModelsFromJson(String str) => CatalogModels.fromJson(json.decode(str));
String catalogModelsToJson(CatalogModels data) => json.encode(data.toJson());
class CatalogModels {
  CatalogModels({
      num? id, 
      String? name, 
      String? desc, 
      num? price, 
      String? image,}){
    _id = id;
    _name = name;
    _desc = desc;
    _price = price;
    _image = image;
}

  CatalogModels.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _desc = json['desc'];
    _price = json['price'];
    _image = json['image'];
  }
  num? _id;
  String? _name;
  String? _desc;
  num? _price;
  String? _image;
CatalogModels copyWith({  num? id,
  String? name,
  String? desc,
  num? price,
  String? image,
}) => CatalogModels(  id: id ?? _id,
  name: name ?? _name,
  desc: desc ?? _desc,
  price: price ?? _price,
  image: image ?? _image,
);
  num? get id => _id;
  String? get name => _name;
  String? get desc => _desc;
  num? get price => _price;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
    map['price'] = _price;
    map['image'] = _image;
    return map;
  }

}