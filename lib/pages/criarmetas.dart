import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meudentinho/componentes/customtextForm.dart';

import '../config.dart';

class CriarMetas extends StatefulWidget {
  CriarMetas({Key? key, required this.uid}) : super(key: key);
  String uid;
  final idadeMask = MaskTextInputFormatter(
      mask: '##/##/####', filter: {'#': RegExp(r'[0-9]')});
  @override
  State<CriarMetas> createState() => _CriarMetasState();
}

class _CriarMetasState extends State<CriarMetas> {
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection('Usuarios');
  TextEditingController pontosControl = TextEditingController();
  TextEditingController inicioControl = TextEditingController();
  TextEditingController terminoControl = TextEditingController();
  TextEditingController premioControl = TextEditingController();
  String pontosAtuais = '0';
  String status = 'em andamento';
  String adminEmail = '';
  String adminPass = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmailAdmin();
    getData();
  }

  String t1 = '00:00';
  String t2 = '00:00';
  String t3 = '00:00';

  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    var size = MediaQuery.of(context).size;
    var padBottom = MediaQuery.of(context).padding.bottom;
    var padTop = MediaQuery.of(context).padding.top;
    var padTotal = padTop + padBottom;
    TimeOfDay time =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
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
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: Get.size.height * 0.85,
                width: Get.size.width,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                decoration: BoxDecoration(
                  gradient: gradient,
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
                        'CRIAR META',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //ListView
                    Expanded(
                      child: Container(
                        height: 50,
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(size.width * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.1),
                                ),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Obs.: Cada ponto equivale a uma escovação.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: titulo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      CustomTextForm(
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                        icon: Icons.rocket_launch,
                                        label: 'Pontos Desejados',
                                        controller: pontosControl,
                                      ),
                                      CustomTextForm(
                                        maskType: [widget.idadeMask],
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                        icon: Icons.calendar_month,
                                        label: 'Data de Inicio',
                                        controller: inicioControl,
                                      ),
                                      CustomTextForm(
                                        maskType: [widget.idadeMask],
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                        icon: Icons.calendar_month,
                                        label: 'Data de Termino',
                                        controller: terminoControl,
                                      ),
                                      CustomTextForm(
                                        icon: Icons.card_giftcard,
                                        label: 'Prêmio',
                                        controller: premioControl,
                                      ),
                                      Container(
                                        height: 50,
                                        width: Get.size.width,
                                        child: ElevatedButton(
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
                                          onPressed: () async {
                                            if (pontosControl.text != null &&
                                                pontosControl.text.isNotEmpty &&
                                                inicioControl.text != null &&
                                                inicioControl.text.isNotEmpty &&
                                                terminoControl.text != null &&
                                                terminoControl
                                                    .text.isNotEmpty &&
                                                premioControl.text != null &&
                                                premioControl.text.isNotEmpty) {
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(widget.uid)
                                                  .collection('Meta')
                                                  .doc('Meta')
                                                  .set({
                                                'pontosdesejados':
                                                    pontosControl.text,
                                                'pontosatuais': pontosAtuais,
                                                'datainicio':
                                                    inicioControl.text,
                                                'datatermino':
                                                    terminoControl.text,
                                                'premio': premioControl.text,
                                                'status': status,
                                              });
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text(
                                            'Criar Meta',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getEmailAdmin() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      var mail = await refUser
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) {
        var data = value.data() as Map<String, dynamic>;
        adminEmail = data['email'];
        adminPass = data['senha'];

        print(adminEmail + ' | ' + adminPass);
      });
    } else {
      print('nenhum usuário logado!');
    }
  }

  void getData() async {
    final CollectionReference docRef = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Escovacao');
    var esc1 = docRef.doc('1').get().then((value) {
      setState(() {
        t1 = value['hora'];
      });
    });
    var esc2 = docRef.doc('2').get().then((value) {
      setState(() {
        t2 = value['hora'];
      });
    });
    var esc3 = docRef.doc('3').get().then((value) {
      setState(() {
        t3 = value['hora'];
      });
    });
  }
}
