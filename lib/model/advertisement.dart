class Advertisement {
  int? id;
  String? url;
  String? path;
  String? imgName;
  String? imgType;
  String? name;

  Advertisement({
    this.id,
    this.url,
    this.path,
    this.imgName,
    this.imgType,
    this.name,
  });

  Advertisement copyWith({
    int? id,
    String? url,
    String? path,
    String? imgName,
    String? imgType,
    String? name,
  }) {
    return Advertisement(
        id: id ?? this.id,
        url: url ?? this.url,
        path: path ?? this.path,
        imgName: imgName ?? this.imgName,
        imgType: imgType ?? this.imgType,
        name: name ?? this.name);
  }

  factory Advertisement.fromDocs(Map<String, dynamic> ds) {
    return Advertisement(
        id: ds['id'],
        url: ds['url'],
        path: ds['path'],
        imgName: ds['imgimgName'],
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
