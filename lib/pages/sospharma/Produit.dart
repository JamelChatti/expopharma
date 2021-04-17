class Produit {
  String id;
  String name;
  int nbreDemande;
  int timestamp;
  Produit.id();
  Produit(this.id, this.name, this.nbreDemande, this.timestamp);

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      json['id'],
      json['name'],
      json['nbreDemande'],
      json['timestamp'],
    );
  }
  Map<String, dynamic> toJson() =>{
    'id' : id ,
    'name': name ,
    'nbreDemande' : nbreDemande ,
  };
}
