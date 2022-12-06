import 'package:meudentinho/models/itemModel.dart';

ItemModel maika = ItemModel(
  name: 'Dra. Maika',
  imgUrl: 'https://dente.digital/wp-content/uploads/2022/05/Dentista-1.png',
  especialidade: 'Cirurgião Dentista',
  locais: 'Petrolina - PE: Clínica X, Clínica Y',
  descricao:
      'A Dra. Maika é  Designer de Sorrisos, Especialista em Lentes de Contato Dental. Consultório Odontológico em Salvador, Equipe Altamente Especializada',
  whatsapp: '(74)9999-9999',
  instagram: 'maika',
);
ItemModel eric = ItemModel(
  name: 'Dr. Eric',
  imgUrl:
      'https://www.sorriamanaus.com.br/wp-content/uploads/2019/04/dentista.png',
  especialidade: 'Cirurgião Dentista',
  locais: 'Juazeiro - BA: Clínica X, Clínica Y',
  descricao:
      'O Dr. Erick é Designer de Sorrisos, Especialista em Lentes de Contato Dental. Consultório Odontológico em Salvador, Equipe Altamente Especializada',
  whatsapp: '(74)9999-9999',
  instagram: 'eric',
);
List<ItemModel> produtos = [eric, maika];
