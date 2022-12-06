import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/pages/especialistas.dart';
import 'package:meudentinho/pages/metadiaria.dart';
import 'package:meudentinho/pages/minhaescovacao.dart';
import 'package:meudentinho/pages/nossahistoria.dart';
import 'package:meudentinho/pages/startScreen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.uid}) : super(key: key);
  String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _HomePageState extends State<HomePage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    initInfo();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    return Scaffold(
      key: _key,
      drawer: Drawer(
        width: Get.size.width * 0.7,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 86,
                        width: 86,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            filterQuality: FilterQuality.medium,
                            image: AssetImage('assets/images/denteazul.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Menu Principal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: titulo,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Início',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MinhaEscovacao()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Minha Escovação',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MetaDiaria()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Meta Diária',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => NossaHistoria()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Nossa História',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Especialistas()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Fale com um Dentista',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    try {
                      FirebaseAuth.instance.signOut();
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Saindo da Conta...',
                            textAlign: TextAlign.center,
                          )));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => StartScreen()),
                          (route) => false);
                    } catch (e) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Erro ao tentar deslogar',
                            textAlign: TextAlign.center,
                          )));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: gradientSair,
                    ),
                    child: Text('Sair',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //AppBar{Como escovar os dentes corretamente, Minha escovação, Meta Diária, Nossa História, Fale com o dentista, Sair}
            //AppBar{Como escovar os dentes corretamente, Minha escovação, Meta Diária, Nossa História, Fale com o dentista, Sair}
            Stack(
              children: [
                Container(
                  height: 150,
                  width: Get.width,
                  color: Color.fromRGBO(41, 212, 244, 1),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Color.fromRGBO(41, 212, 244, 1),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _key.currentState!.openDrawer();
                                });
                              },
                              child: Ink(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/dentebranco.png',
                                  scale: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    'Meu Dentinho',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(),
                        ],
                      )
                    ],
                  ),
                ),
                //Card{Foto, Nome, Dia/Noite @ hora, Meta Diária}
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    width: cardWidth,
                    margin: EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [shadow]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/fotoperfil.png'))),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Column(
                                children: [
                                  Text(
                                    'Adailton Gama',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.wb_sunny,
                                        color: Colors.yellow[700],
                                        size: 20,
                                      ),
                                      Text(
                                        'Hoje - 07:45',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                              'Meta Diária de Escovação',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '80%',
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
                              width: tamanhobarra * 0.8,
                              decoration: BoxDecoration(
                                color: frontBar,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                // margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                height: 50,
                width: Get.size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      //Escovação do Dia
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [shadow],
                        ),
                        width: cardWidth,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Escovação do Dia',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: backVerde,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: secondary, onPrimary: backVerde),
                              onPressed: () async {
                                String time =
                                    '${DateTime.now().hour}:${DateTime.now().minute}';
                                String nome = 'Adailton';
                                String title = 'Escovação do $nome';
                                String body =
                                    '$nome, fez a 1º Escovação do dia! às $time.';
                                if (nome != "") {
                                  DocumentSnapshot snap =
                                      await FirebaseFirestore.instance
                                          .collection('Usuarios')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .get();
                                  String token = snap['token'];
                                  print(token);
                                  sendPushMessage(token, body, title);
                                }
                              },
                              child: Text(
                                'Enviar Escovação',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      //Relatório Semanal
                      Container(
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [shadow],
                        ),
                        width: cardWidth,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: [
                            Text(
                              'Relatório Semanal',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dia',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                Container(),
                                Container(),
                                Text(
                                  'Minha Escovação',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                Container(),
                              ],
                            ),
                            //Segunda
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Segunda-Feira',
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
                            ),
                            //Terça
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Terça-Feira',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Quarta
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quarta-Feira',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Quinta
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quinta-Feira',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Sexta
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sexta-Feira',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Sábado
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sábado',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Domingo
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: tamanhobarra - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Domingo',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        //Quantidade de Escovações
                                        Text(
                                          '2',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Relatório Diario{Contador Diário de Escovação: >2 vezes ao dia, 1 vez ao dia, 0 vezes ao dia}

            //Relatório Semanal
          ],
        ),
      ),
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA7p8Cpag:APA91bER64RHN6_Dzerkj0iP7cTq-3QtSDp4TburDJg9E07apboc5X3e0gZKPbniBetQysSBaS0IcAqc8IJ3POHH5l7X82VMwlrvINH2W9UEEgXMJvDLrP_fFUv-ARurwgI4UVp6pF0v'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                "title": title,
                "body": body,
                "android_channel_id": "lembrete"
              },
              "to": token,
            },
          ));
    } catch (e) {
      if (kDebugMode) {
        print("error push notifications $e");
      }
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Usuário Autorizado');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Usuário com permissão temporária');
    } else {
      print('Usuário com permissão negada');
    }
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("..............Messagem..............");
      print(
          "Messagem: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'lembrete',
        'lembrete',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const IOSNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }
}
