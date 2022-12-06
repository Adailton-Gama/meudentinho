import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meudentinho/pages/criarmetas.dart';
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

  String feita1 = 'não';
  String time1 = '00:00';
  String feita2 = 'não';
  String time2 = '00:00';
  String feita3 = 'não';
  String time3 = '00:00';
  String datainicio = '';
  String datatermino = '';
  String premio = '';
  String pontosatuais = '';
  String pontosdesejados = '';
  String status = '';
  double porcentagem = 0;
  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    CollectionReference historico = FirebaseFirestore.instance
        .collection('Historico')
        .doc(widget.uid)
        .collection('Historico');
    int qtd = 0;
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CriarMetas(uid: widget.uid)));
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
                            ],
                          ),
                        ),
                        Container(
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
                            ],
                          ),
                        ),
                        Container(
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
                                    pontosatuais,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    pontosdesejados,
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
                                    pontosatuais,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    pontosdesejados,
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
                              '${porcentagem * 100}%',
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
                          'Status da Escovação:',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),

                    Container(
                      height: Get.size.height * 0.38,
                      width: Get.size.width,
                      child: Expanded(
                        child: StreamBuilder(
                          stream: historico.snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            snapshot.data!.docs[index];
                                        if (documentSnapshot['time1'] ==
                                            'sim') {
                                          print('time1 ok');
                                          qtd++;
                                        }
                                        if (documentSnapshot['time2'] ==
                                            'sim') {
                                          print('time2 ok');
                                          qtd++;
                                        }
                                        if (documentSnapshot['time3'] ==
                                            'sim') {
                                          print('time3 ok');
                                          qtd++;
                                        }
                                        return Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        documentSnapshot['qtd'],
                                                        style: TextStyle(
                                                            color: Colors.white,
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
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 0, 0, 0),
                                                      height: 24,
                                                      width: 24,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 0, 0, 0),
                                                      height: 24,
                                                      width: 24,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 0, 0, 0),
                                                      height: 24,
                                                      width: 24,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
        pontosatuais = value['pontosatuais'];
        pontosdesejados = value['pontosdesejados'];
        status = value['status'];
        var num = (int.parse(pontosatuais) / int.parse(pontosdesejados)) * 100;
        porcentagem = num / 100;
        print(porcentagem);
      });
    });
  }
}
