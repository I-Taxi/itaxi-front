class Advertisement {
  int? id;
  String? url;
  String? path;
  String? imgName;
  String? imgType;
  String? name;
  String? byte;

  Advertisement({
    this.id,
    this.url,
    this.path,
    this.imgName,
    this.imgType,
    this.name,
    this.byte,
  });

  Advertisement.getImage({this.byte, this.url});

  Advertisement copyWith({
    int? id,
    String? url,
    String? path,
    String? imgName,
    String? imgType,
    String? name,
    String? byte,
  }) {
    return Advertisement(
        id: id ?? this.id,
        url: url ?? this.url,
        path: path ?? this.path,
        imgName: imgName ?? this.imgName,
        imgType: imgType ?? this.imgType,
        name: name ?? this.name,
        byte: byte ?? this.byte);
  }

  factory Advertisement.getImageFrom(Map<String, dynamic> ds) {
    return Advertisement.getImage(url: ds['url'], byte: ds['image']);
  }

  factory Advertisement.fromDocs(Map<String, dynamic> ds) {
    return Advertisement(
        id: ds['id'],
        url: ds['url'],
        path: ds['path'],
        imgName: ds['imgName'],
        imgType: ds['imgType'],
        name: ds['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'path': path,
      'imgName': imgName,
      'imgType': imgType,
      'name': name,
    };
  }
}
