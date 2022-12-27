import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meudentinho/pages/criarmetas.dart';
import 'package:meudentinho/pages/definirescovacao.dart';
import 'package:meudentinho/pages/detailsHistorico.dart';
import 'package:meudentinho/pages/editarcrianca.dart';
import 'package:http/http.dart' as http;

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
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  String nome = '';
  String fotoLocal = '';
  String pontos = '';
  String sexo = 'Menino';
  Timer? timer;
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    timer = Timer.periodic(Duration(seconds: 10), (timer) => getData());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
    print('Timer Cancelado!');
  }

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
  int pontosdesejados = 0;
  String status = '';
  double porcentagem = 0;
  double valorporcentagem = 0;
  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    var historico = FirebaseFirestore.instance
        .collection('Historico')
        .doc(widget.uid)
        .collection('Historico')
        .orderBy('data');
    int qtd = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sexo == 'Menino' ? background : secondaryRosa,
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
                      // color: sexo == 'Menino' ? background : backgroundRosa,
                      gradient: sexo == 'Menino' ? gradient : gradientRosa,
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: sexo == 'Menino'
                                        ? Colors.white
                                        : secondaryRosa,
                                  ),
                                ),
                                Text(
                                  'Pontuação: $pontosatuais',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: sexo == 'Menino'
                                        ? Colors.white
                                        : secondaryRosa,
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
                          primary: sexo == 'Menino' ? titulo : secondaryRosa,
                          onPrimary:
                              sexo == 'Menino' ? background : backgroundRosa,
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
                          primary: sexo == 'Menino' ? titulo : secondaryRosa,
                          onPrimary:
                              sexo == 'Menino' ? background : backgroundRosa,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => DefinirEscovacao(
                                    uid: widget.uid,
                                    sexo: sexo,
                                  ))));
                        },
                        child: Text(
                          'Definir Escovação',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: sexo == 'Menino' ? titulo : secondaryRosa,
                          onPrimary:
                              sexo == 'Menino' ? background : backgroundRosa,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CriarMetas(uid: widget.uid, sexo: sexo)));
                        },
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
                  gradient: sexo == 'Menino' ? gradient : gradientRosa,
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
                        color: sexo == 'Menino' ? titulo : secondaryRosa,
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
                              color: feita1 == 'sim'
                                  ? Colors.green
                                  : feita1 == 'pendente'
                                      ? secondary
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius: BorderRadius.circular(100),
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
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: feita2 == 'sim'
                                  ? Colors.green
                                  : feita2 == 'pendente'
                                      ? secondary
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius: BorderRadius.circular(100),
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
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: feita3 == 'sim'
                                  ? Colors.green
                                  : feita3 == 'pendente'
                                      ? secondary
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius: BorderRadius.circular(100),
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
                        color: sexo == 'Menino' ? titulo : secondaryRosa,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progresso para a recompensa',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${valorporcentagem.toStringAsFixed(2)}%',
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
                                color:
                                    sexo == 'Menino' ? backBar : backgroundRosa,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: tamanhobarra * porcentagem,
                              decoration: BoxDecoration(
                                color: sexo == 'Menino'
                                    ? secondary
                                    : secondaryRosa,
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
                            onPressed: pontosatuais >= pontosdesejados
                                ? () async {
                                    String time =
                                        '${DateTime.now().hour}:${DateTime.now().minute}';

                                    String title = 'Seu Prêmio Chegou!';
                                    String nomeRes = '';
                                    var res = await FirebaseFirestore.instance
                                        .collection('Usuarios')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .get()
                                        .then((value) {
                                      nomeRes = value['nome'];
                                    });
                                    String body =
                                        ' Parabéns $nome, você concluiu a sua meta de escovação, fale com $nomeRes, para receber seu Prêmio!!!';
                                    DocumentSnapshot snap =
                                        await FirebaseFirestore.instance
                                            .collection('Usuarios')
                                            .doc(widget.uid)
                                            .get();
                                    String token = snap['token'];
                                    sendPushMessage(token, body, title);
                                  }
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_giftcard,
                                  color: pontosatuais >= pontosdesejados
                                      ? sexo == 'Menino'
                                          ? titulo
                                          : secondaryRosa
                                      : Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  pontosatuais >= pontosdesejados
                                      ? 'Dar Prêmio'
                                      : 'Em andamento',
                                  style: TextStyle(
                                    color: pontosatuais >= pontosdesejados
                                        ? sexo == 'Menino'
                                            ? titulo
                                            : secondaryRosa
                                        : Colors.white,
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
                        color: sexo == 'Menino' ? titulo : secondaryRosa,
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
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(),
                        Container(),
                        Text(
                          'Status da Escovação:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: Get.size.height * 0.38,
                      width: Get.size.width,
                      child: StreamBuilder(
                        stream: historico.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                height: Get.size.height * 0.3,
                                width: Get.size.width * 0.9,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];
                                      if (documentSnapshot['time1'] == 'sim') {
                                        print('time1 ok');
                                        qtd++;
                                      }
                                      if (documentSnapshot['time2'] == 'sim') {
                                        print('time2 ok');
                                        qtd++;
                                      }
                                      if (documentSnapshot['time3'] == 'sim') {
                                        print('time3 ok');
                                        qtd++;
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  documentSnapshot['time3'] ==
                                                              'sim' ||
                                                          documentSnapshot[
                                                                  'time3'] ==
                                                              'pendente'
                                                      ? DetailsHistorico(
                                                          pontosatuais:
                                                              pontosatuais,
                                                          uid: widget.uid,
                                                          feito3:
                                                              documentSnapshot[
                                                                  'time3'],
                                                          feito2:
                                                              documentSnapshot[
                                                                  'time2'],
                                                          feito1:
                                                              documentSnapshot[
                                                                  'time1'],
                                                          data:
                                                              documentSnapshot[
                                                                  'data'],
                                                          hora1:
                                                              documentSnapshot[
                                                                  'hora1'],
                                                          foto1:
                                                              documentSnapshot[
                                                                  'foto1'],
                                                          hora2:
                                                              documentSnapshot[
                                                                  'hora2'],
                                                          foto2:
                                                              documentSnapshot[
                                                                  'foto2'],
                                                          hora3:
                                                              documentSnapshot[
                                                                  'hora3'],
                                                          foto3:
                                                              documentSnapshot[
                                                                  'foto3'],
                                                        )
                                                      : documentSnapshot[
                                                                      'time2'] ==
                                                                  'sim' ||
                                                              documentSnapshot[
                                                                      'time2'] ==
                                                                  'pendente'
                                                          ? DetailsHistorico(
                                                              pontosatuais:
                                                                  pontosatuais,
                                                              uid: widget.uid,
                                                              feito2:
                                                                  documentSnapshot[
                                                                      'time2'],
                                                              feito1:
                                                                  documentSnapshot[
                                                                      'time1'],
                                                              data:
                                                                  documentSnapshot[
                                                                      'data'],
                                                              hora1:
                                                                  documentSnapshot[
                                                                      'hora1'],
                                                              foto1:
                                                                  documentSnapshot[
                                                                      'foto1'],
                                                              hora2:
                                                                  documentSnapshot[
                                                                      'hora2'],
                                                              foto2:
                                                                  documentSnapshot[
                                                                      'foto2'],
                                                            )
                                                          : DetailsHistorico(
                                                              pontosatuais:
                                                                  pontosatuais,
                                                              uid: widget.uid,
                                                              feito1:
                                                                  documentSnapshot[
                                                                      'time1'],
                                                              data:
                                                                  documentSnapshot[
                                                                      'data'],
                                                              hora1:
                                                                  documentSnapshot[
                                                                      'hora1'],
                                                              foto1:
                                                                  documentSnapshot[
                                                                      'foto1'],
                                                            ),
                                            ),
                                          );
                                          print('apertado');
                                          print(
                                              '3: ${documentSnapshot['time3']}');
                                          print(
                                              '2: ${documentSnapshot['time2']}');
                                          print(
                                              '1: ${documentSnapshot['time1']}');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: sexo == 'Menino'
                                                ? titulo
                                                : secondaryRosa,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [shadow],
                                          ),
                                          margin: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Column(
                                            children: [
                                              Row(
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
                                                                      .w500),
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
                                                                        .w500),
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
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text('Ver Detalhes',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
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
                  ],
                ),
              ),
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
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Criancas')
        .doc(widget.uid)
        .get();
    setState(() {
      nome = docRef['nome'];
      sexo = docRef['sexo'];
      var nomeseparado = nome.split(' ');
      for (int i = 0; i < nomeseparado.length; i++) {
        nomeseparado[i] =
            nomeseparado[i][0].toUpperCase() + nomeseparado[i].substring(1);
      }
      fotoLocal = docRef['foto'];
      pontos = docRef['pontos'];
      nome = nomeseparado.join(' ');
    });

    //
    //
    final CollectionReference escovacao = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Escovacao');
    var esc1 = escovacao.doc('1').get().then((value) {
      setState(() {
        feita1 = value['feita'];
        time1 = value['hora'];
      });
    });
    var esc2 = escovacao.doc('2').get().then((value) {
      setState(() {
        feita2 = value['feita'];
        time2 = value['hora'];
      });
    });
    var esc3 = escovacao.doc('3').get().then((value) {
      setState(() {
        feita3 = value['feita'];
        time3 = value['hora'];
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
        pontosatuais = int.parse(value['pontosatuais'].toString());
        pontosdesejados = int.parse(value['pontosdesejados']);
        status = value['status'].toString();
        var num = pontosatuais / pontosdesejados * 100;
        porcentagem = num / 100;
        valorporcentagem = porcentagem * 100;
        print(porcentagem);
        print(pontosatuais);
        print(pontosdesejados);
      });
    });
  }
}
