import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../componentes/customtextForm.dart';
import '../config.dart';

class CriarPerfilDentista extends StatefulWidget {
  CriarPerfilDentista({Key? key, required this.uid}) : super(key: key);
  String uid;
  final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
  final idadeMask = MaskTextInputFormatter(
      mask: '##/##/####', filter: {'#': RegExp(r'[0-9]')});
  final phoneMask = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {'#': RegExp(r'[0-9]')});
  @override
  State<CriarPerfilDentista> createState() => _CriarPerfilDentistaState();
}

class _CriarPerfilDentistaState extends State<CriarPerfilDentista> {
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection('Usuarios');

  TextEditingController nomeControl = TextEditingController();
  TextEditingController espControl = TextEditingController();
  TextEditingController localControl = TextEditingController();
  TextEditingController descControl = TextEditingController();
  TextEditingController whatsControl = TextEditingController();
  TextEditingController instaControl = TextEditingController();

  String adminEmail = '';
  String adminPass = '';
  String _foto = '';
  PickedFile? foto;
  String fotoLocal =
      'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975';
  String ftP =
      'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975';
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmailAdmin();
    getData();
  }

  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 20;
    var size = MediaQuery.of(context).size;
    var padBottom = MediaQuery.of(context).padding.bottom;
    var padTop = MediaQuery.of(context).padding.top;
    var padTotal = padTop + padBottom;

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
                        'CADASTRAR PERFIL',
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
                                      GestureDetector(
                                        onTap: () async {
                                          final storage =
                                              FirebaseStorage.instance;

                                          var ref = FirebaseFirestore.instance
                                              .collection('Usuarios')
                                              .doc(widget.uid);

                                          PickedFile? fotoPerfil =
                                              await ImagePicker().getImage(
                                                  source: ImageSource.gallery);
                                          var file = File(fotoPerfil!.path);
                                          var cadFoto = await storage
                                              .ref()
                                              .child(
                                                  'usuarios/${widget.uid}/foto/perfil/')
                                              .putFile(file);
                                          //
                                          var imgUrl = await cadFoto.ref
                                              .getDownloadURL();
                                          //
                                          ref.update({
                                            'fotoperfil': imgUrl,
                                          });
                                          //
                                          setState(() {
                                            fotoLocal = imgUrl;
                                          });
                                          //
                                        },
                                        child: Container(
                                          height: 180,
                                          width: Get.size.width,
                                          padding: EdgeInsets.all(10),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            color: background,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: _foto.isNotEmpty
                                                  ? NetworkImage(_foto)
                                                  : NetworkImage(
                                                      fotoLocal,
                                                    ),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              fotoLocal == ftP
                                                  ? 'Escolher Imagem'
                                                  : '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      CustomTextForm(
                                        controller: nomeControl,
                                        icon: Icons.person,
                                        label: 'Nome',
                                      ),
                                      CustomTextForm(
                                        controller: espControl,
                                        icon: Icons.person,
                                        label: 'Especialização',
                                      ),
                                      CustomTextForm(
                                        controller: localControl,
                                        icon: Icons.local_hospital,
                                        label: 'Locais:',
                                        isSecret: false,
                                      ),
                                      CustomTextForm(
                                        isSecret: false,
                                        controller: descControl,
                                        icon: Icons.calendar_month,
                                        label: 'Descrição',
                                      ),
                                      CustomTextForm(
                                        controller: whatsControl,
                                        icon: Icons.description,
                                        label: 'WhatsApp',
                                        maskType: [widget.phoneMask],
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                      ),
                                      CustomTextForm(
                                        controller: instaControl,
                                        icon: Icons.family_restroom,
                                        label: 'Instagram',
                                      ),
                                      SizedBox(
                                        height: 50,
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
                                            try {
                                              if (nomeControl.text.isNotEmpty &&
                                                  espControl.text.isNotEmpty &&
                                                  localControl
                                                      .text.isNotEmpty &&
                                                  descControl.text.isNotEmpty &&
                                                  whatsControl
                                                      .text.isNotEmpty &&
                                                  instaControl
                                                      .text.isNotEmpty) {
                                                try {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Usuarios')
                                                      .doc(widget.uid)
                                                      .collection('Perfil')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser?.uid
                                                          .toString())
                                                      .update({
                                                    'uid': FirebaseAuth.instance
                                                        .currentUser?.uid
                                                        .toString(),
                                                    'nome': nomeControl.text,
                                                    'especializacao':
                                                        espControl.text,
                                                    'locais': localControl.text,
                                                    'descricao':
                                                        descControl.text,
                                                    'whatsapp':
                                                        whatsControl.text,
                                                    'instagram':
                                                        instaControl.text,
                                                    'foto': fotoLocal,
                                                  });
                                                } catch (e) {
                                                  try {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Usuarios')
                                                        .doc(widget.uid)
                                                        .collection('Perfil')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid
                                                            .toString())
                                                        .set({
                                                      'uid': FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          ?.uid
                                                          .toString(),
                                                      'nome': nomeControl.text,
                                                      'especializacao':
                                                          espControl.text,
                                                      'locais':
                                                          localControl.text,
                                                      'descricao':
                                                          descControl.text,
                                                      'whatsapp':
                                                          whatsControl.text,
                                                      'instagram':
                                                          instaControl.text,
                                                      'foto': fotoLocal,
                                                    });
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                }
                                                await FirebaseFirestore.instance
                                                    .collection('Usuarios')
                                                    .doc(widget.uid)
                                                    .update({
                                                  'foto': fotoLocal,
                                                  'especializacao':
                                                      espControl.text,
                                                  'perfil': 'feito',
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                            'Usuário: ${nomeControl.text} cadastrado com sucesso!')));
                                                setState(() {
                                                  nomeControl.clear();
                                                  espControl.clear();
                                                  localControl.clear();
                                                  descControl.clear();
                                                  whatsControl.clear();
                                                  instaControl.clear();
                                                });

                                                Navigator.of(context).pop();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )));
                                              }
                                            } on FirebaseException catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                        'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )));
                                            }
                                          },
                                          child: Text(
                                            'Atualizar Perfil',
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
    var docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Perfil')
        .get()
        .then((value) {
      setState(() {
        nomeControl.text = value.docs[0]['nome'];
        espControl.text = value.docs[0]['especializacao'];
        localControl.text = value.docs[0]['locais'];
        descControl.text = value.docs[0]['descricao'];
        whatsControl.text = value.docs[0]['whatsapp'];
        instaControl.text = value.docs[0]['instagram'];
        fotoLocal = value.docs[0]['foto'];
      });
    });
  }
}
