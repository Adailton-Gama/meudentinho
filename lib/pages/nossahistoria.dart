import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/pages/startScreen.dart';
import 'package:meudentinho/pages/teladentista.dart';
import 'package:meudentinho/pages/telaresponsavel.dart';

import '../config.dart';
import '../homepage.dart';
import 'especialistas.dart';
import 'metadiaria.dart';
import 'comoescovar.dart';

class NossaHistoria extends StatefulWidget {
  const NossaHistoria({Key? key}) : super(key: key);

  @override
  State<NossaHistoria> createState() => _NossaHistoriaState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _NossaHistoriaState extends State<NossaHistoria> {
  String tipo = '';
  String sexo = 'Menino';
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
          sexo = value['sexo'];
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
                                child: Text('In??cio',
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
                            //       child: Text('Minha Escova????o',
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
                            //       child: Text('Meta Di??ria',
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
                                child: Text('Nossa Hist??ria',
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
        centerTitle: true,
        title: Text('Nossa Hist??ria'),
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
                    'Nossa Hist??ria',
                    style: TextStyle(
                      color: sexo == 'Menino' ? titulo : secondaryRosa,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tudo Come??ou com a cria????o de um projeto para Disciplina de Ci??ncias Sociais, da turma do 1?? per??odo do curso de Odontologia noturno da Faculdade Soberana.\n[...]',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Parceria',
                    style: TextStyle(
                      color: sexo == 'Menino' ? titulo : secondaryRosa,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'O projeto conta com a parceria da Faculdade Soberana, a qual tem dado apoio e suporte para a evolu????o do mesmo.\n[...]',
                    textAlign: TextAlign.justify,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image:
                                AssetImage('assets/icon/LOGO SOBERANA.png'))),
                  ),
                  Text(
                    '''
        \nEquipe:
        1. Olavo Barros Jr
        2.  Edithe Brito
        3. Hercton Lima 
        4. Jaqueline Bastos
        5. Gesilda Lima
        6. Ja??ne Alves
        7. Marjory lopes
        8.Tiago Teixeira
                    ''',
                    style: TextStyle(
                      color: sexo == 'Menino' ? titulo : secondaryRosa,
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
