class Lecture {
  List<Url>? url;

  Lecture({this.url});

  Lecture.fromJson(Map<String, dynamic> json) {
    if (json['url'] != null) {
      url = <Url>[];
      json['url'].forEach((v) {
        url!.add(new Url.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.url != null) {
      data['url'] = this.url!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Url {
  String? quality;
  String? url;

  Url({this.quality, this.url});

  Url.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['url'] = this.url;
    return data;
  }
}