import 'dart:convert';

class ItemModel {
  String name;
  String imgUrl;
  String especialidade;
  String locais;
  String descricao;
  String whatsapp;
  String instagram;

  ItemModel({
    required this.name,
    required this.imgUrl,
    required this.especialidade,
    required this.locais,
    required this.descricao,
    required this.whatsapp,
    required this.instagram,
  });

  ItemModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imgUrl = json['imgUrl'],
        especialidade = json['especialidade'],
        locais = json['locais'],
        whatsapp = json['whatsapp'],
        descricao = json['descricao'],
        instagram = json['instagram'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'especialidade': especialidade,
      'locais': locais,
      'descricao': descricao,
      'whatsapp': whatsapp,
      'instagram': instagram,
    };
  }
}
