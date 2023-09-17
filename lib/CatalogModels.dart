import 'dart:convert';
/// id : 1
/// name : "Iphone 14 pro"
/// desc : "Apple Iphone 14th generation"
/// price : 999
/// image : "https://www.pakmobizone.pk/wp-content/uploads/2022/12/Apple-iPhone-14-Pro-Max-Silver-4.jpg"
/// info : "The iPhone 14 Pro is a flagship smartphone from Apple, known for its cutting-edge technology and sleek design. With powerful performance, a stunning display, and advanced camera capabilities, it sets a new standard in the world of mobile devices. Elevate your mobile experience with the iPhone 14 Pro."
/// camera : "equipped with the 48MP camera"
/// video : "4K HDR at 30 fps"
/// processor : "A16 Bionic"
/// memory : "128GB, 256GB, 512GB, and 1TB"
/// battery : "3,200mAh"
/// screen : "6.12 inches with OLED display"
/// pictures : ["https://www.pakmobizone.pk/wp-content/uploads/2022/12/Apple-iPhone-14-Pro-Max-Silver-4.jpg","https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-14-pro-max-1.jpg"]

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
      String? screen, 
      List<String>? pictures,}){

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
    _pictures = pictures;
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
    _pictures = json['pictures'] != null ? json['pictures'].cast<String>() : [];
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
  List<String>? _pictures;

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
  List<String>? pictures,
}) => CatalogModels(  id: id ?? _id,
  name: name ?? _name,
  desc: desc ?? _desc,
  price: price ?? _price,
  image: image ?? _image,
  info: info ?? _info,
  camera: camera ?? _camera,
  video: video ?? _video,
  processor: processor ?? _processor,
  memory: memory ?? _memory,
  battery: battery ?? _battery,
  screen: screen ?? _screen,
  pictures: pictures ?? _pictures,
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
  List<String>? get pictures => _pictures;

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
    map['pictures'] = _pictures;
    return map;
  }

}