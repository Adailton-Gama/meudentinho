import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meudentinho/componentes/especialistadetails.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/models/itemModel.dart';

class EspecialistasTile extends StatefulWidget {
  EspecialistasTile({
    Key? key,
    required this.uid,
    required this.especialidade,
    required this.imgUrl,
    required this.name,
  }) : super(key: key);
  String uid;
  String imgUrl;
  String name;
  String especialidade;
  @override
  State<EspecialistasTile> createState() => _EspecialistasTileState();
}

class _EspecialistasTileState extends State<EspecialistasTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EspecialistaDetails(
                    uid: widget.uid, imgUrl: widget.imgUrl)));
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey.shade300,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Imagem
            Expanded(
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: background,
                ),
                child: Hero(
                  tag: widget.imgUrl,
                  child: Image.network(widget.imgUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Nome
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900]),
                  ),
                  //Preço - Unidade
                  Text(
                    widget.especialidade,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
