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
      String? image,
      String? info,
    String? camera,
    String? video,
    String? processor,
    String? memory,
    String? battery,
    String? screen,})
  {
    _id = id;
    _name = name;
    _desc = desc;
    _price = price;
    _image = image;
    _info = info;
    _camera = camera;
    _video = video;
    _processor = processor;
    _memory = memory;
    _battery = battery;
    _screen = screen;
}

  CatalogModels.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _desc = json['desc'];
    _price = json['price'];
    _image = json['image'];
    _info = json['info'];
    _camera = json['camera'];
    _video = json['video'];
    _processor = json['processor'];
    _memory = json['memory'];
    _battery = json['battery'];
    _screen = json['screen'];
  }
  num? _id;
  String? _name;
  String? _desc;
  num? _price;
  String? _image;
  String? _info;
  String? _camera;
  String? _video;
  String? _processor;
  String? _memory;
  String? _battery;
  String? _screen;

CatalogModels copyWith({  num? id,
  String? name,
  String? desc,
  num? price,
  String? image,
  String? info,
  String? camera,
  String? video,
  String? processor,
  String? memory,
  String? battery,
  String? screen,

}) => CatalogModels(  id: id ?? _id,
  name: name ?? _name,
  desc: desc ?? _desc,
  price: price ?? _price,
  image: image ?? _image,
  info: info ?? _info,
  camera: camera ?? _camera,
  video: video ?? _video,
  processor: processor ?? _processor,
  memory: _memory ?? _memory,
  battery: _battery ?? _battery,
  screen: _screen ?? _screen,

);
  num? get id => _id;
  String? get name => _name;
  String? get desc => _desc;
  num? get price => _price;
  String? get image => _image;
  String? get info => _info;
  String? get camera => _camera;
  String? get video => _video;
  String? get processor => _processor;
  String? get memory => _memory;
  String? get battery => _battery;
  String? get screen => _screen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
    map['price'] = _price;
    map['image'] = _image;
    map['info'] = _info;
    map['camera'] = _camera;
    map['video'] = _video;
    map['processor'] = _processor;
    map['memory'] = _memory;
    map['battery'] = _battery;
    map['screen'] = _screen;
    return map;
  }
}