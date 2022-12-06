import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/pages/definirescovacao.dart';
import 'package:meudentinho/pages/editarcrianca.dart';

import '../config.dart';

class EditarCrianca extends StatefulWidget {
  EditarCrianca({
    Key? key,
    required this.uid,
  }) : super(key: key);
  String uid;
  @override
  State<EditarCrianca> createState() => _EditarCriancaState();
}

class _EditarCriancaState extends State<EditarCrianca> {
  @override
  String nome = '';
  String fotoLocal = '';
  String pontos = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dentebranco.png',
              scale: 20,
            ),
            SizedBox(width: 5),
            Text('Meu Dentinho'),
          ],
        ),
      ),
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: cardWidth,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [shadow]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(fotoLocal))),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nome,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Pontuação: $pontos',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //Botão
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: titulo,
                          onPrimary: background,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditarDadosCrianca(
                                    uid: widget.uid,
                                  )));
                        },
                        child: Text(
                          'Editar Perfil',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: titulo,
                          onPrimary: background,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  DefinirEscovacao(uid: widget.uid))));
                        },
                        child: Text(
                          'Definir Escovação',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: titulo,
                          onPrimary: background,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Criar Meta',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.size.width,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                decoration: BoxDecoration(
                  gradient: gradient,
                  boxShadow: [shadow],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    //Escovação do Dia
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: titulo,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Escovação do Dia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: backVerde,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1º Escovação',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '07:00',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2º Escovação',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '12:00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3º Escovação',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '20:00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //
                    //Meta
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: titulo,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Meta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '01/11/2022 - 01/12/2022',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Text(
                          'Prêmio: Nintendo Switch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        //Escovações e Pontuação
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ESCOVAÇÕES',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    '15',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'de 90',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              height: 100,
                              width: 1,
                              color: Colors.white,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PONTUAÇÃO',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    '15',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'de 90',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progresso para a recompensa',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '16.66%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        //Barra de Progresso
                        Stack(
                          children: [
                            Container(
                              height: 10,
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: backBar,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: tamanhobarra * 0.1666,
                              decoration: BoxDecoration(
                                color: secondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: titulo,
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_giftcard,
                                  color: titulo,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Dar Prêmio',
                                  style: TextStyle(
                                    color: titulo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    //
                    //Histórico de Escovação
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: titulo,
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Histórico de Escovação',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dia',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Container(),
                        Container(),
                        Text(
                          'Minha Escovação',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Container(),
                      ],
                    ),

                    Container(
                      height: Get.size.height * 0.38,
                      width: Get.size.width,
                      child: Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return //Segunda
                                  Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: tamanhobarra * 0.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '03/12/2022',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          //Quantidade de Escovações
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Status
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    DocumentSnapshot docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Criancas')
        .doc(widget.uid)
        .get();
    setState(() {
      nome = docRef['nome'];
      fotoLocal = docRef['foto'];
      pontos = docRef['pontos'];
    });
  }
}
