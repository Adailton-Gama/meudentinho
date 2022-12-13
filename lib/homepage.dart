import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/pages/especialistas.dart';
import 'package:meudentinho/pages/metadiaria.dart';
import 'package:meudentinho/pages/comoescovar.dart';
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
    getData();
    initInfo();
    Future.delayed(Duration(seconds: 3)).then((value) => getData());
  }

  String nome = '';
  String _foto = '';

  String fotoLocal = '';
  String pontos = '';
  String feita1 = 'não';
  String time1 = '00:00';
  String feita2 = 'não';
  String time2 = '00:00';
  String feita3 = 'não';
  String time3 = '00:00';
  String datainicio = '';
  String datatermino = '';
  String premio = '';
  int pontosatuais = 0;
  String pontosdesejados = '';
  String status = '';
  double porcentagem = 0;
  double valorporc = 0;

  var dia;
  @override
  Widget build(BuildContext context) {
    //
    //
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    var historico = FirebaseFirestore.instance
        .collection('Historico')
        .doc(widget.uid)
        .collection('Historico')
        .orderBy('data');
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
                                        builder: (context) => ComoEscovar()),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text('Como escovar meu dentinho',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.of(context).pushAndRemoveUntil(
                            //         MaterialPageRoute(
                            //             builder: (context) => MetaDiaria()),
                            //         (route) => false);
                            //   },
                            //   child: Container(
                            //     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20),
                            //       gradient: gradient,
                            //     ),
                            //     child: Text('Meta Diária',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w800,
                            //           color: Colors.white,
                            //         )),
                            //   ),
                            // ),
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
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: Text('Nossa História'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //AppBar{Como escovar os dentes corretamente, Minha escovação, Meta Diária, Nossa História, Fale com o dentista, Sair}
              //AppBar{Como escovar os dentes corretamente, Minha escovação, Meta Diária, Nossa História, Fale com o dentista, Sair}

              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      width: Get.size.width * 0.9,
                      margin: EdgeInsets.only(bottom: 10, top: 10),
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 5),
                                        Icon(
                                          dia == 'sol'
                                              ? Icons.wb_sunny
                                              : Icons.dark_mode_rounded,
                                          color: dia == 'sol'
                                              ? Colors.yellow[700]
                                              : Colors.grey[700],
                                          size: 20,
                                        ),
                                        Text(
                                          ' ${DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.now())}',
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
                                '${valorporc.toStringAsFixed(2)}%',
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
                                width: tamanhobarra * porcentagem,
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
                    //Escovação do Dia
                    Container(
                      padding: EdgeInsets.all(10),
                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      width: Get.size.width * 0.9,
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
                      children: [
                        Container(
                          width: Get.size.width * 0.9,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: feita1 == 'sim' ? backVerde : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1º Escovação',
                                style: TextStyle(
                                    color: feita1 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                time1,
                                style: TextStyle(
                                    color: feita1 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
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
                                  feita1 == 'sim' ? Icons.done : Icons.close,
                                  color: feita1 == 'sim'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              feita1 == 'sim'
                                  ? Container()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: secondary,
                                          onPrimary: backVerde),
                                      onPressed: () async {
                                        final storage =
                                            FirebaseStorage.instance;

                                        var ref = FirebaseFirestore.instance
                                            .collection('Usuarios')
                                            .doc(widget.uid);

                                        PickedFile? fotoPerfil =
                                            await ImagePicker().getImage(
                                                source: ImageSource.camera);
                                        var file = File(fotoPerfil!.path);
                                        var cadFoto = await storage
                                            .ref()
                                            .child(
                                                'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/1')
                                            .putFile(file);
                                        //
                                        var imgUrl =
                                            await cadFoto.ref.getDownloadURL();
                                        //

                                        String time =
                                            '${DateTime.now().hour}:${DateTime.now().minute}';

                                        String title = 'Escovação do(a) $nome';
                                        String body =
                                            '$nome, fez a 1º Escovação do dia! às $time.';
                                        if (nome != "") {
                                          try {
                                            DocumentSnapshot snap =
                                                await FirebaseFirestore.instance
                                                    .collection('Usuarios')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get();

                                            var uidRes = snap['uidRes'];
                                            DocumentSnapshot snapRes =
                                                await FirebaseFirestore.instance
                                                    .collection('Usuarios')
                                                    .doc(uidRes)
                                                    .get();
                                            String token = snapRes['token'];

                                            print(token);
                                            sendPushMessage(token, body, title);
                                            await FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(widget.uid)
                                                .collection('Escovacao')
                                                .doc('1')
                                                .update({'feita': 'sim'});
                                            var qtd;
                                            var total;
                                            try {
                                              await FirebaseFirestore.instance
                                                ..collection('Historico')
                                                    .doc(widget.uid)
                                                    .collection('Historico')
                                                    .doc(DateFormat('ddMMyyyy')
                                                        .format(DateTime.now()))
                                                    .get()
                                                    .then((value) {
                                                  qtd = value['qtd'];
                                                  if (qtd == null) {
                                                    qtd = 0;
                                                  }
                                                  total = int.parse(qtd + 1);
                                                });
                                              await FirebaseFirestore.instance
                                                  .collection('Historico')
                                                  .doc(widget.uid)
                                                  .collection('Historico')
                                                  .doc(DateFormat('ddMMyyyy')
                                                      .format(DateTime.now()))
                                                  .update({
                                                'data': DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
                                                'qtd': '1',
                                                'time1': 'sim',
                                                'time2': 'não',
                                                'time3': 'não',
                                                'foto1': imgUrl,
                                                'hora1': DateFormat(
                                                        'dd/MM/yyyy - hh:mm')
                                                    .format(DateTime.now()),
                                              });
                                            } catch (e) {
                                              await FirebaseFirestore.instance
                                                  .collection('Historico')
                                                  .doc(widget.uid)
                                                  .collection('Historico')
                                                  .doc(DateFormat('ddMMyyyy')
                                                      .format(DateTime.now()))
                                                  .set({
                                                'data': DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
                                                'qtd': '1',
                                                'time1': 'sim',
                                                'time2': 'não',
                                                'time3': 'não',
                                                'foto1': imgUrl,
                                                'hora1': DateFormat(
                                                        'dd/MM/yyyy - hh:mm')
                                                    .format(DateTime.now()),
                                              });
                                            }
                                          } catch (e) {}
                                        }
                                        var ponto = await pontosatuais + 1;
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('Usuarios')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('Meta')
                                              .doc('Meta')
                                              .update({'pontosatuais': ponto});
                                          await FirebaseFirestore.instance
                                              .collection('Usuarios')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .update({'pontos': ponto});
                                        } catch (e) {
                                          await FirebaseFirestore.instance
                                              .collection('Usuarios')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('Meta')
                                              .doc('Meta')
                                              .set({'pontosatuais': ponto});
                                          await FirebaseFirestore.instance
                                              .collection('Usuarios')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .update({'pontos': ponto});
                                        }
                                        await Future.delayed(
                                            Duration(seconds: 2));
                                        getData();
                                      },
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.size.width * 0.9,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: feita2 == 'sim' ? backVerde : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2º Escovação',
                                style: TextStyle(
                                    color: feita2 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                time2,
                                style: TextStyle(
                                    color: feita2 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
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
                                  feita2 == 'sim' ? Icons.done : Icons.close,
                                  color: feita2 == 'sim'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              feita2 == 'sim'
                                  ? Container()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: secondary,
                                          onPrimary: backVerde),
                                      onPressed: feita1 == 'não'
                                          ? null
                                          : () async {
                                              final storage =
                                                  FirebaseStorage.instance;

                                              var ref = FirebaseFirestore
                                                  .instance
                                                  .collection('Usuarios')
                                                  .doc(widget.uid);

                                              PickedFile? fotoPerfil =
                                                  await ImagePicker().getImage(
                                                      source:
                                                          ImageSource.camera);
                                              var file = File(fotoPerfil!.path);
                                              var cadFoto = await storage
                                                  .ref()
                                                  .child(
                                                      'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/2')
                                                  .putFile(file);
                                              //
                                              var imgUrl = await cadFoto.ref
                                                  .getDownloadURL();
                                              //

                                              String time =
                                                  '${DateTime.now().hour}:${DateTime.now().minute}';

                                              String title =
                                                  'Escovação do(a) $nome';
                                              String body =
                                                  '$nome, fez a 2º Escovação do dia! às $time.';
                                              if (nome != "") {
                                                try {
                                                  DocumentSnapshot snap =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .get();

                                                  var uidRes = snap['uidRes'];
                                                  DocumentSnapshot snapRes =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(uidRes)
                                                          .get();
                                                  String token =
                                                      snapRes['token'];

                                                  print(token);
                                                  sendPushMessage(
                                                      token, body, title);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Usuarios')
                                                      .doc(widget.uid)
                                                      .collection('Escovacao')
                                                      .doc('2')
                                                      .update({'feita': 'sim'});
                                                  var qtd;
                                                  var total;
                                                  try {
                                                    await FirebaseFirestore
                                                        .instance
                                                      ..collection('Historico')
                                                          .doc(widget.uid)
                                                          .collection(
                                                              'Historico')
                                                          .doc(DateFormat(
                                                                  'ddMMyyyy')
                                                              .format(DateTime
                                                                  .now()))
                                                          .get()
                                                          .then((value) {
                                                        qtd = value['qtd'];

                                                        total =
                                                            int.parse(qtd + 1);
                                                      });

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Historico')
                                                        .doc(widget.uid)
                                                        .collection('Historico')
                                                        .doc(DateFormat(
                                                                'ddMMyyyy')
                                                            .format(
                                                                DateTime.now()))
                                                        .update({
                                                      'data': DateFormat(
                                                              'dd/MM/yyyy')
                                                          .format(
                                                              DateTime.now()),
                                                      'qtd': '2',
                                                      'time2': 'sim',
                                                      'foto2': imgUrl,
                                                      'hora2': DateFormat(
                                                              'dd/MM/yyyy - hh:mm')
                                                          .format(
                                                              DateTime.now()),
                                                    });
                                                  } catch (e) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Historico')
                                                        .doc(widget.uid)
                                                        .collection('Historico')
                                                        .doc(DateFormat(
                                                                'ddMMyyyy')
                                                            .format(
                                                                DateTime.now()))
                                                        .get()
                                                        .then((value) async {
                                                      qtd = value['qtd'];

                                                      total =
                                                          int.parse(qtd + 1);
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Historico')
                                                          .doc(widget.uid)
                                                          .collection(
                                                              'Historico')
                                                          .doc(DateFormat(
                                                                  'ddMMyyyy')
                                                              .format(DateTime
                                                                  .now()))
                                                          .set({
                                                        'data': DateFormat(
                                                                'dd/MM/yyyy')
                                                            .format(
                                                                DateTime.now()),
                                                        'qtd': '2',
                                                        'time2': 'sim',
                                                        'foto2': imgUrl,
                                                        'hora2': DateFormat(
                                                                'dd/MM/yyyy - hh:mm')
                                                            .format(
                                                                DateTime.now()),
                                                      });
                                                    });
                                                  }
                                                } catch (e) {}
                                              }
                                              var ponto =
                                                  await pontosatuais + 1;
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('Meta')
                                                  .doc('Meta')
                                                  .update(
                                                      {'pontosatuais': ponto});
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({'pontos': ponto});
                                              await Future.delayed(
                                                  Duration(seconds: 2));
                                              getData();
                                            },
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.size.width * 0.9,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: feita3 == 'sim' ? backVerde : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3º Escovação',
                                style: TextStyle(
                                    color: feita3 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                time3,
                                style: TextStyle(
                                    color: feita3 == 'sim'
                                        ? Colors.blue
                                        : Colors.white,
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
                                  feita3 == 'sim' ? Icons.done : Icons.close,
                                  color: feita3 == 'sim'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              feita3 == 'sim'
                                  ? Container()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: secondary,
                                          onPrimary: backVerde),
                                      onPressed: feita2 == 'não'
                                          ? null
                                          : () async {
                                              final storage =
                                                  FirebaseStorage.instance;

                                              var ref = FirebaseFirestore
                                                  .instance
                                                  .collection('Usuarios')
                                                  .doc(widget.uid);

                                              PickedFile? fotoPerfil =
                                                  await ImagePicker().getImage(
                                                      source:
                                                          ImageSource.camera);
                                              var file = File(fotoPerfil!.path);
                                              var cadFoto = await storage
                                                  .ref()
                                                  .child(
                                                      'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/3')
                                                  .putFile(file);
                                              //
                                              var imgUrl = await cadFoto.ref
                                                  .getDownloadURL();
                                              //

                                              String time =
                                                  '${DateTime.now().hour}:${DateTime.now().minute}';

                                              String title =
                                                  'Escovação do(a) $nome';
                                              String body =
                                                  '$nome, fez a 3º Escovação do dia! às $time.';
                                              if (nome != "") {
                                                try {
                                                  DocumentSnapshot snap =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .get();

                                                  var uidRes = snap['uidRes'];
                                                  DocumentSnapshot snapRes =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(uidRes)
                                                          .get();
                                                  String token =
                                                      snapRes['token'];

                                                  print(token);
                                                  sendPushMessage(
                                                      token, body, title);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Usuarios')
                                                      .doc(widget.uid)
                                                      .collection('Escovacao')
                                                      .doc('3')
                                                      .update({'feita': 'sim'});
                                                  var qtd;
                                                  int total = 0;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Historico')
                                                      .doc(widget.uid)
                                                      .collection('Historico')
                                                      .doc(DateFormat(
                                                              'ddMMyyyy')
                                                          .format(
                                                              DateTime.now()))
                                                      .get()
                                                      .then((value) async {
                                                    qtd =
                                                        int.parse(value['qtd']);

                                                    total = int.parse(qtd + 1);
                                                  });
                                                } catch (e) {
                                                  print(e.toString());
                                                }
                                              }
                                              await FirebaseFirestore.instance
                                                  .collection('Historico')
                                                  .doc(widget.uid)
                                                  .collection('Historico')
                                                  .doc(DateFormat('ddMMyyyy')
                                                      .format(DateTime.now()))
                                                  .update({
                                                'data': DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
                                                'qtd': '3',
                                                'time3': 'sim',
                                                'foto3': imgUrl,
                                                'hora3': DateFormat(
                                                        'dd/MM/yyyy - hh:mm')
                                                    .format(DateTime.now()),
                                              });
                                              var ponto =
                                                  await pontosatuais + 1;
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('Meta')
                                                  .doc('Meta')
                                                  .update(
                                                      {'pontosatuais': ponto});
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({'pontos': ponto});
                                              await Future.delayed(
                                                  Duration(seconds: 2));
                                              getData();
                                            },
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //Relatório Semanal
                    Container(
                      height: Get.size.height * 0.38,
                      width: Get.size.width * 0.9,
                      decoration: BoxDecoration(
                          boxShadow: [shadow],
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(20)),
                      child: StreamBuilder(
                        stream: historico.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                height: Get.size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];

                                      return Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: tamanhobarra * 0.5,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    documentSnapshot['data'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  //Quantidade de Escovações
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      documentSnapshot['qtd']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Icon(
                                                      documentSnapshot[
                                                                  'time1'] ==
                                                              'sim'
                                                          ? Icons.done
                                                          : Icons.close,
                                                      color: documentSnapshot[
                                                                  'time1'] ==
                                                              'sim'
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Icon(
                                                      documentSnapshot[
                                                                  'time2'] ==
                                                              'sim'
                                                          ? Icons.done
                                                          : Icons.close,
                                                      color: documentSnapshot[
                                                                  'time2'] ==
                                                              'sim'
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Icon(
                                                      documentSnapshot[
                                                                  'time3'] ==
                                                              'sim'
                                                          ? Icons.done
                                                          : Icons.close,
                                                      color: documentSnapshot[
                                                                  'time3'] ==
                                                              'sim'
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }));
                          } else if (snapshot.hasError) {
                            print('erro: ${snapshot.error.toString()}');
                            return Center(
                              child:
                                  Text('error: ${snapshot.error.toString()}'),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              //Relatório Diario{Contador Diário de Escovação: >2 vezes ao dia, 1 vez ao dia, 0 vezes ao dia}

              //Relatório Semanal
            ],
          ),
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
      criticalAlert: true,
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

  void getData() async {
    DocumentSnapshot docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .get();
    setState(() {
      nome = docRef['nome'];
      fotoLocal = docRef['foto'];
    });

    //
    //
    final CollectionReference escovacao = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Escovacao');
    escovacao.doc('1').get().then((value) async {
      if (value['data'] != DateFormat('dd/MM/yyyy').format(DateTime.now())) {
        await escovacao.doc('1').update({
          'data': '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
          'feita': 'não'
        });
        await escovacao.doc('2').update({
          'data': '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
          'feita': 'não'
        });
        await escovacao.doc('3').update({
          'data': '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
          'feita': 'não'
        });
      }
    });
    var esc1 = escovacao.doc('1').get().then((value) {
      setState(() {
        feita1 = value['feita'];
        time1 = value['hora'];
        print(time1);
      });
    });
    var esc2 = escovacao.doc('2').get().then((value) {
      setState(() {
        feita2 = value['feita'];
        time2 = value['hora'];
        print(time2);
      });
    });
    var esc3 = escovacao.doc('3').get().then((value) {
      setState(() {
        feita3 = value['feita'];
        time3 = value['hora'];
        print(time3);
      });
    });
    DocumentReference meta = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Meta')
        .doc('Meta');
    meta.get().then((value) {
      setState(() {
        datainicio = value['datainicio'];
        datatermino = value['datatermino'];
        premio = value['premio'];
        pontosatuais = value['pontosatuais'];
        pontosdesejados = value['pontosdesejados'];
        status = value['status'];
        var num = pontosatuais / int.parse(pontosdesejados) * 100;
        porcentagem = num / 100;
        valorporc = porcentagem * 100;
        print(porcentagem);
        var hora = DateTime.now().hour;
        if (hora < 18) {
          dia = 'sol';
        } else {
          dia = 'lua';
        }
      });
    });
  }
}
