import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config.dart';

class DefinirEscovacao extends StatefulWidget {
  DefinirEscovacao({Key? key, required this.uid}) : super(key: key);
  String uid;
  @override
  State<DefinirEscovacao> createState() => _DefinirEscovacaoState();
}

class _DefinirEscovacaoState extends State<DefinirEscovacao> {
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection('Usuarios');
  TextEditingController emailControl = TextEditingController();
  TextEditingController senhaControl = TextEditingController();
  TextEditingController nomeControl = TextEditingController();
  TextEditingController idadeControl = TextEditingController();
  TextEditingController cpfControl = TextEditingController();
  TextEditingController parentescoControl = TextEditingController();
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
                        'DEFINIR HORÁRIOS',
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
                                      //1
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '1º Escovação',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              t1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 5, 0, 20),
                                        width: Get.size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: background,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                          ),
                                          onPressed: () async {
                                            TimeOfDay? newTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: time,
                                            );
                                            if (newTime == null) return;
                                            setState(() => time = newTime);
                                            String hora = time.hour
                                                .toString()
                                                .padLeft(2, '0');
                                            String min = time.minute
                                                .toString()
                                                .padLeft(2, '0');
                                            String horaCompleta = '$hora:$min';
                                            setState(() {
                                              t1 = horaCompleta;
                                            });
                                            print(DateFormat('dd/MM/yyyy')
                                                .format(DateTime.now()));
                                            print(widget.uid);
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('Usuarios')
                                                  .doc(widget.uid)
                                                  .collection('Escovacao')
                                                  .doc('1')
                                                  .set({
                                                'nome': '1° Escovação',
                                                'hora': horaCompleta,
                                                'data':
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                                'feita': 'não'
                                              });
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          child: Text(
                                            'Cadastrar 1º Horário',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //2
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                              t2,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 5, 0, 20),
                                        width: Get.size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: background,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                          ),
                                          onPressed: () async {
                                            TimeOfDay? newTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: time,
                                            );
                                            if (newTime == null) return;
                                            setState(() => time = newTime);
                                            String hora = time.hour
                                                .toString()
                                                .padLeft(2, '0');
                                            String min = time.minute
                                                .toString()
                                                .padLeft(2, '0');
                                            String horaCompleta = '$hora:$min';
                                            setState(() {
                                              t2 = horaCompleta;
                                            });
                                            print(DateFormat('dd/MM/yyyy')
                                                .format(DateTime.now()));
                                            await FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(widget.uid)
                                                .collection('Escovacao')
                                                .doc('2')
                                                .set({
                                              'nome': '2° Escovação',
                                              'hora': horaCompleta,
                                              'data':
                                                  '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                              'feita': 'não'
                                            });
                                          },
                                          child: Text(
                                            'Cadastrar 2º Horário',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //3
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '3º Escovação',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  t3,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Container(),
                                              ])),
                                      Container(
                                        height: 50,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 5, 0, 20),
                                        width: Get.size.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: background,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                          ),
                                          onPressed: () async {
                                            TimeOfDay? newTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: time,
                                            );
                                            if (newTime == null) return;
                                            setState(() => time = newTime);
                                            String hora = time.hour
                                                .toString()
                                                .padLeft(2, '0');
                                            String min = time.minute
                                                .toString()
                                                .padLeft(2, '0');
                                            String horaCompleta = '$hora:$min';
                                            setState(() {
                                              t3 = horaCompleta;
                                            });
                                            print(DateFormat('dd/MM/yyyy')
                                                .format(DateTime.now()));
                                            await FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(widget.uid)
                                                .collection('Escovacao')
                                                .doc('3')
                                                .set({
                                              'nome': '3° Escovação',
                                              'hora': horaCompleta,
                                              'data':
                                                  '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                              'feita': 'não'
                                            });
                                          },
                                          child: Text(
                                            'Cadastrar 3º Horário',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
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
    DocumentSnapshot docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .get();
    setState(() {
      emailControl.text = docRef['email'];
      senhaControl.text = docRef['senha'];
      nomeControl.text = docRef['nome'];
      idadeControl.text = docRef['idade'];
      cpfControl.text = docRef['cpf'];
      parentescoControl.text = docRef['parentesco'];
    });
  }
}