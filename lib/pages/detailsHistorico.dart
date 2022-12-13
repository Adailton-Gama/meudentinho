import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/config.dart';

class DetailsHistorico extends StatefulWidget {
  DetailsHistorico({
    Key? key,
    required this.data,
    required this.hora1,
    required this.foto1,
    required this.hora2,
    required this.foto2,
    required this.hora3,
    required this.foto3,
  }) : super(key: key);
  String data;
  String hora1;
  String foto1;
  String hora2;
  String foto2;
  String hora3;
  String foto3;

  @override
  State<DetailsHistorico> createState() => _DetailsHistoricoState();
}

class _DetailsHistoricoState extends State<DetailsHistorico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Data: ${widget.data}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1º Escovação: ${widget.hora1}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Get.size.height * 0.8,
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [shadow],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.foto1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Data: ${widget.data}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2º Escovação: ${widget.hora2}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Get.size.height * 0.8,
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [shadow],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.foto2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Data: ${widget.data}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '3º Escovação: ${widget.hora3}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Get.size.height * 0.8,
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [shadow],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.foto3),
                      ),
                    ),
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
