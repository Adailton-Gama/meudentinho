import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/componentes/especialistastile.dart';
import 'package:meudentinho/pages/minhaescovacao.dart';
import 'package:meudentinho/models/app_data.dart' as appdata;
import 'package:meudentinho/pages/startScreen.dart';
import 'package:meudentinho/pages/teladentista.dart';
import 'package:meudentinho/pages/telaresponsavel.dart';

import '../config.dart';
import '../homepage.dart';
import 'metadiaria.dart';
import 'nossahistoria.dart';

class Especialistas extends StatefulWidget {
  const Especialistas({Key? key}) : super(key: key);

  @override
  State<Especialistas> createState() => _EspecialistasState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _EspecialistasState extends State<Especialistas> {
  String tipo = '';
  List dentistas = [];
  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(uid)
          .get()
          .then((value) {
        String nivel = value['nivel'].toString();
        setState(() {
          tipo = nivel;
        });
      });
      getDentistas();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
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
                                if (tipo == 'responsavel') {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => TelaResponsavel(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid)),
                                      (route) => false);
                                } else if (tipo == 'dentista') {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => TelaDentista(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid)),
                                      (route) => false);
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                              uid: FirebaseAuth
                                                  .instance.currentUser!.uid)),
                                      (route) => false);
                                }
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
                            if (tipo != 'responsavel' && tipo != 'dentista')
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MinhaEscovacao()),
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
                            if (tipo != 'responsavel' && tipo != 'dentista')
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
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Saindo da Conta...',
                            textAlign: TextAlign.center,
                          )));
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
        backgroundColor: background,
        centerTitle: true,
        title: Text('Fale com um Especialista'),
      ),
      body: SafeArea(
          child: Container(
        height: Get.size.height * 0.8,
        width: Get.size.width,
        child: Column(
          children: [
            Container(
              height: Get.size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                ),
                itemCount: dentistas.length,
                itemBuilder: (context, index) {
                  return EspecialistasTile(
                    uid: dentistas[index]['uid'],
                    especialidade: dentistas[index]['especializacao'],
                    imgUrl: dentistas[index]['foto'],
                    name: dentistas[index]['nome'],
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  void getDentistas() async {
    var result = await FirebaseFirestore.instance
        .collection('Usuarios')
        .where('nivel', isEqualTo: 'dentista')
        .get();
    setState(() {
      dentistas = result.docs.map((e) => e.data()).toList();
    });
  }
}
