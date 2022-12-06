import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/pages/startScreen.dart';
import 'package:meudentinho/pages/telaresponsavel.dart';

import '../config.dart';
import '../homepage.dart';
import 'especialistas.dart';
import 'metadiaria.dart';
import 'minhaescovacao.dart';

class NossaHistoria extends StatefulWidget {
  const NossaHistoria({Key? key}) : super(key: key);

  @override
  State<NossaHistoria> createState() => _NossaHistoriaState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _NossaHistoriaState extends State<NossaHistoria> {
  String tipo = '';
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
                                          builder: (context) => HomePage(
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
                            // if (tipo != 'responsavel' && tipo != 'dentista')
                            //   GestureDetector(
                            //     onTap: () {
                            //       Navigator.of(context).pushAndRemoveUntil(
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   MinhaEscovacao()),
                            //           (route) => false);
                            //     },
                            //     child: Container(
                            //       margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //       padding: EdgeInsets.all(10),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         gradient: gradient,
                            //       ),
                            //       child: Text('Minha Escovação',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w800,
                            //             color: Colors.white,
                            //           )),
                            //     ),
                            //   ),
                            // if (tipo != 'responsavel' && tipo != 'dentista')
                            //   GestureDetector(
                            //     onTap: () {
                            //       Navigator.of(context).pushAndRemoveUntil(
                            //           MaterialPageRoute(
                            //               builder: (context) => MetaDiaria()),
                            //           (route) => false);
                            //     },
                            //     child: Container(
                            //       margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //       padding: EdgeInsets.all(10),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         gradient: gradient,
                            //       ),
                            //       child: Text('Meta Diária',
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.w800,
                            //             color: Colors.white,
                            //           )),
                            //     ),
                            //   ),
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
        title: Text('Nossa História'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Nossa História',
                    style: TextStyle(
                      color: titulo,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tudo Começou com a criação de um projeto para Disciplina de Ciências Sociais, da turma do 1º período do curso de Odontologia noturno da Faculdade Soberana.\n[...]',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Parceria',
                    style: TextStyle(
                      color: titulo,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'O projeto conta com a parceria da Faculdade Soberana, a qual tem dado apoio e suporte para a evolução do mesmo.\n[...]',
                    textAlign: TextAlign.justify,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icon/icon.png'))),
                  ),
                  Text(
                    '''
        \nEquipe:
        1. Olavo Barros Jr
        2.  Edithe Brito
        3. Hercton Lima 
        4. Jaqueline Bastos
        5. Gesilda Lima
        6. Jaíne Alves
        7. Marjory lopes
        8.Tiago Teixeira
                    ''',
                    style: TextStyle(
                      color: titulo,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
