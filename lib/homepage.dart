import 'dart:async';
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
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getData();
    initInfo();
    Future.delayed(Duration(seconds: 3)).then((value) => getData());
    timer = Timer.periodic(Duration(seconds: 10), (timer) => getData());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
    print('Timer Cancelado!');
  }

  String nome = '';
  String _foto = '';
  String sexo = 'Menino';
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
                                          builder: (context) =>
                                              NossaHistoria()),
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
                                          builder: (context) =>
                                              Especialistas()),
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
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              'Saindo da Conta...',
                              textAlign: TextAlign.center,
                            )));
                        await Future.delayed(Duration(milliseconds: 1500));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => StartScreen()),
                            (route) => false);
                      } catch (e) {
                        print(e);
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
          backgroundColor: sexo == 'Menino' ? background : secondaryRosa,
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
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            // height: 150,
                            width: Get.size.width * 0.9,
                            margin: EdgeInsets.only(bottom: 10, top: 10),

                            decoration: BoxDecoration(
                                gradient:
                                    sexo == 'Menino' ? gradient : gradientRosa,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [shadow]),
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    height: 72,
                                    width: 72,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(fotoLocal))),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              //Meta
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  color:
                                      sexo == 'Menino' ? titulo : secondaryRosa,
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
                                    '$datainicio - $datatermino',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Prêmio: $premio',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  //Escovações e Pontuação
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ESCOVAÇÕES',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              pontosatuais.toString(),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              pontosdesejados.toString(),
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'PONTUAÇÃO',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              pontosatuais.toString(),
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              pontosdesejados.toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Progresso para a recompensa',
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
                                          color: sexo == 'Menino'
                                              ? backBar
                                              : backgroundRosa,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width: tamanhobarra * porcentagem,
                                        decoration: BoxDecoration(
                                          color: sexo == 'Menino'
                                              ? secondary
                                              : secondaryRosa,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          //Escovação do Dia
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            decoration: BoxDecoration(
                                gradient:
                                    sexo == 'Menino' ? gradient : gradientRosa,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [shadow]),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  width: Get.size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: sexo == 'Menino'
                                        ? titulo
                                        : secondaryRosa,
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
                                          color: feita1 == 'sim'
                                              ? Colors.green
                                              : feita1 == 'pendente'
                                                  ? secondary
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '1º Escovação',
                                            style: TextStyle(
                                                color: feita1 == 'sim'
                                                    ? Colors.white
                                                    : feita1 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            time1,
                                            style: TextStyle(
                                                color: feita1 == 'sim'
                                                    ? Colors.white
                                                    : feita1 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              size: 20,
                                              feita1 == 'sim'
                                                  ? Icons.done
                                                  : feita1 == 'pendente'
                                                      ? Icons.timer_outlined
                                                      : Icons.close,
                                              color: feita1 == 'sim'
                                                  ? Colors.green
                                                  : feita1 == 'pendente'
                                                      ? Colors.orange
                                                      : Colors.red,
                                            ),
                                          ),
                                          feita1 == 'sim' ||
                                                  feita1 == 'pendente'
                                              ? Container()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: secondary,
                                                          onPrimary: backVerde),
                                                  onPressed: () async {
                                                    final storage =
                                                        FirebaseStorage
                                                            .instance;

                                                    var ref = FirebaseFirestore
                                                        .instance
                                                        .collection('Usuarios')
                                                        .doc(widget.uid);

                                                    PickedFile? fotoPerfil =
                                                        await ImagePicker()
                                                            .getImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    var file =
                                                        File(fotoPerfil!.path);
                                                    var cadFoto = await storage
                                                        .ref()
                                                        .child(
                                                            'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/1')
                                                        .putFile(file);
                                                    //
                                                    var imgUrl = await cadFoto
                                                        .ref
                                                        .getDownloadURL();
                                                    //

                                                    String time =
                                                        '${DateTime.now().hour}:${DateTime.now().minute}';

                                                    String title =
                                                        'Escovação do(a) $nome';
                                                    String body =
                                                        '$nome, fez a 1º Escovação do dia! às $time.';
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

                                                        var uidRes =
                                                            snap['uidRes'];
                                                        DocumentSnapshot
                                                            snapRes =
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
                                                            .collection(
                                                                'Usuarios')
                                                            .doc(widget.uid)
                                                            .collection(
                                                                'Escovacao')
                                                            .doc('1')
                                                            .update({
                                                          'feita': 'pendente'
                                                        });
                                                        var qtd;
                                                        var total;
                                                        try {
                                                          await FirebaseFirestore
                                                              .instance
                                                            ..collection(
                                                                    'Historico')
                                                                .doc(widget.uid)
                                                                .collection(
                                                                    'Historico')
                                                                .doc(DateFormat(
                                                                        'ddMMyyyy')
                                                                    .format(DateTime
                                                                        .now()))
                                                                .get()
                                                                .then((value) {
                                                              qtd =
                                                                  value['qtd'];
                                                              if (qtd == null) {
                                                                qtd = 0;
                                                              }
                                                              total = int.parse(
                                                                  qtd + 1);
                                                            });
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
                                                              .update({
                                                            'data': DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .now()),
                                                            'qtd': '1',
                                                            'time1': 'pendente',
                                                            'time2': 'não',
                                                            'time3': 'não',
                                                            'foto1': imgUrl,
                                                            'hora1': DateFormat(
                                                                    'dd/MM/yyyy - hh:mm')
                                                                .format(DateTime
                                                                    .now()),
                                                          });
                                                        } catch (e) {
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
                                                                .format(DateTime
                                                                    .now()),
                                                            'qtd': '1',
                                                            'time1': 'pendente',
                                                            'time2': 'não',
                                                            'time3': 'não',
                                                            'foto1': imgUrl,
                                                            'hora1': DateFormat(
                                                                    'dd/MM/yyyy - hh:mm')
                                                                .format(DateTime
                                                                    .now()),
                                                          });
                                                        }
                                                      } catch (e) {}
                                                    }
                                                    var ponto =
                                                        await pontosatuais + 1;
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection('Meta')
                                                          .doc('Meta')
                                                          .update({
                                                        'pontosatuais': ponto
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update({
                                                        'pontos': ponto
                                                      });
                                                    } catch (e) {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .collection('Meta')
                                                          .doc('Meta')
                                                          .set({
                                                        'pontosatuais': ponto
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Usuarios')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update({
                                                        'pontos': ponto
                                                      });
                                                    }
                                                    await Future.delayed(
                                                        Duration(seconds: 2));
                                                    getData();
                                                  },
                                                  child: Text(
                                                    'Enviar',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                          color: feita2 == 'sim'
                                              ? Colors.green
                                              : feita2 == 'pendente'
                                                  ? secondary
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '2º Escovação',
                                            style: TextStyle(
                                                color: feita2 == 'sim'
                                                    ? Colors.white
                                                    : feita2 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            time2,
                                            style: TextStyle(
                                                color: feita2 == 'sim'
                                                    ? Colors.white
                                                    : feita2 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              size: 20,
                                              feita2 == 'sim'
                                                  ? Icons.done
                                                  : feita2 == 'pendente'
                                                      ? Icons.timer_outlined
                                                      : Icons.close,
                                              color: feita2 == 'sim'
                                                  ? Colors.green
                                                  : feita2 == 'pendente'
                                                      ? Colors.orange
                                                      : Colors.red,
                                            ),
                                          ),
                                          feita2 == 'sim' ||
                                                  feita2 == 'pendente'
                                              ? Container()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: secondary,
                                                          onPrimary: backVerde),
                                                  onPressed:
                                                      feita1 == 'não' ||
                                                              feita1 ==
                                                                  'pendente'
                                                          ? null
                                                          : () async {
                                                              final storage =
                                                                  FirebaseStorage
                                                                      .instance;

                                                              var ref = FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Usuarios')
                                                                  .doc(widget
                                                                      .uid);

                                                              PickedFile?
                                                                  fotoPerfil =
                                                                  await ImagePicker()
                                                                      .getImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              var file = File(
                                                                  fotoPerfil!
                                                                      .path);
                                                              var cadFoto =
                                                                  await storage
                                                                      .ref()
                                                                      .child(
                                                                          'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/2')
                                                                      .putFile(
                                                                          file);
                                                              //
                                                              var imgUrl =
                                                                  await cadFoto
                                                                      .ref
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
                                                                  DocumentSnapshot snap = await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Usuarios')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .get();

                                                                  var uidRes = snap[
                                                                      'uidRes'];
                                                                  DocumentSnapshot
                                                                      snapRes =
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Usuarios')
                                                                          .doc(
                                                                              uidRes)
                                                                          .get();
                                                                  String token =
                                                                      snapRes[
                                                                          'token'];

                                                                  print(token);
                                                                  sendPushMessage(
                                                                      token,
                                                                      body,
                                                                      title);
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Usuarios')
                                                                      .doc(widget
                                                                          .uid)
                                                                      .collection(
                                                                          'Escovacao')
                                                                      .doc('2')
                                                                      .update({
                                                                    'feita':
                                                                        'pendente'
                                                                  });
                                                                  var qtd;
                                                                  var total;
                                                                  try {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                      ..collection(
                                                                              'Historico')
                                                                          .doc(widget
                                                                              .uid)
                                                                          .collection(
                                                                              'Historico')
                                                                          .doc(DateFormat('ddMMyyyy').format(DateTime
                                                                              .now()))
                                                                          .get()
                                                                          .then(
                                                                              (value) {
                                                                        qtd = value[
                                                                            'qtd'];

                                                                        total = int.parse(
                                                                            qtd +
                                                                                1);
                                                                      });

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Historico')
                                                                        .doc(widget
                                                                            .uid)
                                                                        .collection(
                                                                            'Historico')
                                                                        .doc(DateFormat('ddMMyyyy')
                                                                            .format(DateTime.now()))
                                                                        .update({
                                                                      'data': DateFormat(
                                                                              'dd/MM/yyyy')
                                                                          .format(
                                                                              DateTime.now()),
                                                                      'qtd':
                                                                          '2',
                                                                      'time2':
                                                                          'pendente',
                                                                      'foto2':
                                                                          imgUrl,
                                                                      'hora2': DateFormat(
                                                                              'dd/MM/yyyy - hh:mm')
                                                                          .format(
                                                                              DateTime.now()),
                                                                    });
                                                                  } catch (e) {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Historico')
                                                                        .doc(widget
                                                                            .uid)
                                                                        .collection(
                                                                            'Historico')
                                                                        .doc(DateFormat('ddMMyyyy').format(DateTime
                                                                            .now()))
                                                                        .get()
                                                                        .then(
                                                                            (value) async {
                                                                      qtd = value[
                                                                          'qtd'];

                                                                      total = int
                                                                          .parse(qtd +
                                                                              1);
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Historico')
                                                                          .doc(widget
                                                                              .uid)
                                                                          .collection(
                                                                              'Historico')
                                                                          .doc(DateFormat('ddMMyyyy')
                                                                              .format(DateTime.now()))
                                                                          .set({
                                                                        'data':
                                                                            DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                                                        'qtd':
                                                                            '2',
                                                                        'time2':
                                                                            'pendente',
                                                                        'foto2':
                                                                            imgUrl,
                                                                        'hora2':
                                                                            DateFormat('dd/MM/yyyy - hh:mm').format(DateTime.now()),
                                                                      });
                                                                    });
                                                                  }
                                                                } catch (e) {}
                                                              }
                                                              var ponto =
                                                                  await pontosatuais +
                                                                      1;
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Usuarios')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .collection(
                                                                      'Meta')
                                                                  .doc('Meta')
                                                                  .update({
                                                                'pontosatuais':
                                                                    ponto
                                                              });
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Usuarios')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .update({
                                                                'pontos': ponto
                                                              });
                                                              await Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          2));
                                                              getData();
                                                            },
                                                  child: Text(
                                                    'Enviar',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                          color: feita3 == 'sim'
                                              ? Colors.green
                                              : feita3 == 'pendente'
                                                  ? secondary
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '3º Escovação',
                                            style: TextStyle(
                                                color: feita3 == 'sim'
                                                    ? Colors.white
                                                    : feita3 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            time3,
                                            style: TextStyle(
                                                color: feita3 == 'sim'
                                                    ? Colors.white
                                                    : feita3 == 'pendente'
                                                        ? Colors.orange
                                                        : Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Icon(
                                              size: 20,
                                              feita3 == 'sim'
                                                  ? Icons.done
                                                  : feita3 == 'pendente'
                                                      ? Icons.timer_outlined
                                                      : Icons.close,
                                              color: feita3 == 'sim'
                                                  ? Colors.green
                                                  : feita3 == 'pendente'
                                                      ? Colors.orange
                                                      : Colors.red,
                                            ),
                                          ),
                                          feita3 == 'sim' ||
                                                  feita3 == 'pendente'
                                              ? Container()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: secondary,
                                                          onPrimary: backVerde),
                                                  onPressed: feita2 == 'não' ||
                                                          feita2 == 'pendente'
                                                      ? null
                                                      : () async {
                                                          final storage =
                                                              FirebaseStorage
                                                                  .instance;

                                                          var ref =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Usuarios')
                                                                  .doc(widget
                                                                      .uid);

                                                          PickedFile?
                                                              fotoPerfil =
                                                              await ImagePicker()
                                                                  .getImage(
                                                                      source: ImageSource
                                                                          .camera);
                                                          var file = File(
                                                              fotoPerfil!.path);
                                                          var cadFoto =
                                                              await storage
                                                                  .ref()
                                                                  .child(
                                                                      'usuarios/${widget.uid}/foto/historico/${DateFormat('ddMMyyyy').format(DateTime.now())}/3')
                                                                  .putFile(
                                                                      file);
                                                          //
                                                          var imgUrl = await cadFoto
                                                              .ref
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
                                                              DocumentSnapshot
                                                                  snap =
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Usuarios')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .get();

                                                              var uidRes = snap[
                                                                  'uidRes'];
                                                              DocumentSnapshot
                                                                  snapRes =
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Usuarios')
                                                                      .doc(
                                                                          uidRes)
                                                                      .get();
                                                              String token =
                                                                  snapRes[
                                                                      'token'];

                                                              print(token);
                                                              sendPushMessage(
                                                                  token,
                                                                  body,
                                                                  title);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Usuarios')
                                                                  .doc(widget
                                                                      .uid)
                                                                  .collection(
                                                                      'Escovacao')
                                                                  .doc('3')
                                                                  .update({
                                                                'feita':
                                                                    'pendente'
                                                              });
                                                              var qtd;
                                                              int total = 0;
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Historico')
                                                                  .doc(widget
                                                                      .uid)
                                                                  .collection(
                                                                      'Historico')
                                                                  .doc(DateFormat(
                                                                          'ddMMyyyy')
                                                                      .format(DateTime
                                                                          .now()))
                                                                  .get()
                                                                  .then(
                                                                      (value) async {
                                                                qtd = int.parse(
                                                                    value[
                                                                        'qtd']);

                                                                total =
                                                                    int.parse(
                                                                        qtd +
                                                                            1);
                                                              });
                                                            } catch (e) {
                                                              print(
                                                                  e.toString());
                                                            }
                                                          }
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
                                                              .update({
                                                            'data': DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .now()),
                                                            'qtd': '3',
                                                            'time3': 'pendente',
                                                            'foto3': imgUrl,
                                                            'hora3': DateFormat(
                                                                    'dd/MM/yyyy - hh:mm')
                                                                .format(DateTime
                                                                    .now()),
                                                          });
                                                          var ponto =
                                                              await pontosatuais +
                                                                  1;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Usuarios')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  'Meta')
                                                              .doc('Meta')
                                                              .update({
                                                            'pontosatuais':
                                                                ponto
                                                          });
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Usuarios')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .update({
                                                            'pontos': ponto
                                                          });
                                                          await Future.delayed(
                                                              Duration(
                                                                  seconds: 2));
                                                          getData();
                                                        },
                                                  child: Text(
                                                    'Enviar',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          //Relatório Semanal
                          Container(
                            height: Get.size.height * 0.38,
                            width: Get.size.width * 0.9,
                            decoration: BoxDecoration(
                                boxShadow: [shadow],
                                gradient:
                                    sexo == 'Menino' ? gradient : gradientRosa,
                                borderRadius: BorderRadius.circular(20)),
                            child: StreamBuilder(
                              stream: historico.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      height: Get.size.height * 0.3,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                snapshot.data!.docs[index];

                                            return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: tamanhobarra * 0.5,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          documentSnapshot[
                                                              'data'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              shadows: [
                                                                Shadow(
                                                                    color:
                                                                        secondaryRosa,
                                                                    blurRadius:
                                                                        3,
                                                                    offset: Offset
                                                                        .zero)
                                                              ]),
                                                        ),
                                                        //Quantidade de Escovações
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            documentSnapshot[
                                                                    'qtd']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                shadows: [
                                                                  Shadow(
                                                                      color:
                                                                          secondaryRosa,
                                                                      blurRadius:
                                                                          3,
                                                                      offset: Offset
                                                                          .zero)
                                                                ]),
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
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  5, 0, 0, 0),
                                                          height: 24,
                                                          width: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Icon(
                                                            size: 20,
                                                            documentSnapshot[
                                                                        'time1'] ==
                                                                    'sim'
                                                                ? Icons.done
                                                                : documentSnapshot[
                                                                            'time1'] ==
                                                                        'pendente'
                                                                    ? Icons
                                                                        .timer_outlined
                                                                    : Icons
                                                                        .close,
                                                            color: documentSnapshot[
                                                                        'time1'] ==
                                                                    'sim'
                                                                ? Colors.green
                                                                : documentSnapshot[
                                                                            'time1'] ==
                                                                        'pendente'
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .red,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  5, 0, 0, 0),
                                                          height: 24,
                                                          width: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Icon(
                                                            size: 20,
                                                            documentSnapshot[
                                                                        'time2'] ==
                                                                    'sim'
                                                                ? Icons.done
                                                                : documentSnapshot[
                                                                            'time2'] ==
                                                                        'pendente'
                                                                    ? Icons
                                                                        .timer_outlined
                                                                    : Icons
                                                                        .close,
                                                            color: documentSnapshot[
                                                                        'time2'] ==
                                                                    'sim'
                                                                ? Colors.green
                                                                : documentSnapshot[
                                                                            'time2'] ==
                                                                        'pendente'
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .red,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  5, 0, 0, 0),
                                                          height: 24,
                                                          width: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Icon(
                                                            size: 20,
                                                            documentSnapshot[
                                                                        'time3'] ==
                                                                    'sim'
                                                                ? Icons.done
                                                                : documentSnapshot[
                                                                            'time3'] ==
                                                                        'pendente'
                                                                    ? Icons
                                                                        .timer_outlined
                                                                    : Icons
                                                                        .close,
                                                            color: documentSnapshot[
                                                                        'time3'] ==
                                                                    'sim'
                                                                ? Colors.green
                                                                : documentSnapshot[
                                                                            'time3'] ==
                                                                        'pendente'
                                                                    ? Colors
                                                                        .orange
                                                                    : Colors
                                                                        .red,
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
                                    child: Text(
                                        'error: ${snapshot.error.toString()}'),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                        ]),
                      ),
                    ]))));
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
    String nomeseparado = docRef['nome'];
    var palavra = nomeseparado.split(' ');

    for (int i = 0; i < palavra.length; i++) {
      palavra[i] = palavra[i][0].toUpperCase() + palavra[i].substring(1);
    }
    setState(() {
      sexo = docRef['sexo'];
      nome = palavra.join(' ');

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
