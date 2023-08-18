class Movies {
  String? title;
  String? year;
  String? runtime;
  String? poster;
  String? desc;
  String? channel;
  String? genre;

  Movies({this.title, this.year, this.runtime, this.poster, this.desc, this.channel, this.genre});

  Movies.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    runtime = json['Runtime'];
    poster = json['Poster'];
    desc = json['desc'];
    channel = json['channel'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['Runtime'] = this.runtime;
    data['Poster'] = this.poster;
    data['desc'] = this.desc;
    data['channel'] = this.channel;
    data['genre'] = this.genre;
    return data;
  }
}
