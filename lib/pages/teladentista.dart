import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meudentinho/componentes/especialistadetails.dart';
import 'package:meudentinho/pages/criaperfildentista.dart';
import 'package:meudentinho/pages/editardentista.dart';
import 'package:meudentinho/pages/especialistas.dart';
import 'package:meudentinho/pages/nossahistoria.dart';
import 'package:meudentinho/pages/startScreen.dart';

import '../config.dart';
import '../homepage.dart';

class TelaDentista extends StatefulWidget {
  TelaDentista({
    Key? key,
    required this.uid,
  }) : super(key: key);
  String uid;

  @override
  State<TelaDentista> createState() => _TelaDentistaState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _TelaDentistaState extends State<TelaDentista> {
  String fotoLocal =
      'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975';
  final CollectionReference dentistaRef = FirebaseFirestore.instance
      .collection('Usuarios')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Perfil');
  String sexo = 'Menino';
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Future.delayed(Duration(seconds: 3)).then((value) => getData());
    timer = Timer.periodic(Duration(seconds: 10), (timer) => getData());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
    print('Timer cancelado!');
  }

  String nome = 'Responsável';
  var dia;
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
                  height: 198,
                  width: cardWidth,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
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
                                image: NetworkImage(fotoLocal),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: Get.size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nome.toUpperCase(),
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditarDadosDentista(),
                            ),
                          );
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
                              builder: (context) => CriarPerfilDentista(
                                  uid:
                                      FirebaseAuth.instance.currentUser!.uid)));
                        },
                        child: Text(
                          'Editar Perfil Profissional',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: Get.size.height * 0.51,
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
                        'Perfis Cadastrados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //ListView

                    //
                    //
                    //
                    Container(
                      height: Get.size.height * 0.38,
                      width: Get.size.width,
                      child: StreamBuilder(
                        stream: dentistaRef.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: Get.size.height * 0.3,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        width: Get.size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: shadowColor,
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  gradient: gradient,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          documentSnapshot[
                                                              'foto']))),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nome: ${documentSnapshot['nome']}',
                                                  style: TextStyle(
                                                      color: sexo == 'Menino'
                                                          ? titulo
                                                          : secondaryRosa,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Esp.: ${documentSnapshot['especializacao']}',
                                                  style: TextStyle(
                                                      color: sexo == 'Menino'
                                                          ? titulo
                                                          : secondaryRosa,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Whats: ${documentSnapshot['whatsapp']}',
                                                  style: TextStyle(
                                                      color: sexo == 'Menino'
                                                          ? titulo
                                                          : secondaryRosa,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: sexo == 'Menino'
                                                      ? titulo
                                                      : secondaryRosa,
                                                  onPrimary: sexo == 'Menino'
                                                      ? background
                                                      : backgroundRosa,
                                                  elevation: 3,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EspecialistaDetails(
                                                                uid:
                                                                    documentSnapshot[
                                                                        'uid'],
                                                                imgUrl:
                                                                    documentSnapshot[
                                                                        'foto'],
                                                              )));
                                                },
                                                child: Text(
                                                  'Ver',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
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
        .get();
    setState(() {
      nome = docRef['nome'];
      sexo = docRef['sexo'];
      fotoLocal = docRef['foto'];
      var hora = DateTime.now().hour;
      if (hora < 18) {
        dia = 'sol';
      } else {
        dia = 'lua';
      }
    });
  }
}
