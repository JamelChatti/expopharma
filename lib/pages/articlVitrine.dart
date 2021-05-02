class ArticlVitrine{
  String idVitrine;
  String image;
  String name;

  ArticlVitrine.idVitrine();
  ArticlVitrine(this.idVitrine, this.image, this.name);

  factory ArticlVitrine.fromJson(Map<String, dynamic> json) {
    return ArticlVitrine(
      json['idVitine'],
      json['image'],
      json['name'],
    );
  }
  Map<String, dynamic> toJson() =>{
    'id' : idVitrine ,
    'image': image,
    'name': name ,

  };
}