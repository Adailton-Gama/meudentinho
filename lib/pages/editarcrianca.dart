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

class EditarDadosCrianca extends StatefulWidget {
  EditarDadosCrianca({Key? key, required this.uid}) : super(key: key);
  String uid;
  final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
  final idadeMask = MaskTextInputFormatter(
      mask: '##/##/####', filter: {'#': RegExp(r'[0-9]')});

  @override
  State<EditarDadosCrianca> createState() => _EditarDadosCriancaState();
}

class _EditarDadosCriancaState extends State<EditarDadosCrianca> {
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
  String _foto = '';
  PickedFile? foto;
  String mtoken = '';
  String fotoLocal =
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
                        'ALTERAR CADASTRO',
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
                                            'fotocrianca': imgUrl,
                                          });
                                          //
                                          setState(() {
                                            fotoLocal = imgUrl;
                                          });
                                          //
                                        },
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          padding: EdgeInsets.all(10),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          decoration: BoxDecoration(
                                            color: background,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                              image: _foto.isNotEmpty
                                                  ? NetworkImage(_foto)
                                                  : NetworkImage(
                                                      fotoLocal,
                                                    ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CustomTextForm(
                                        controller: emailControl,
                                        icon: Icons.email,
                                        label: 'E-mail',
                                      ),
                                      CustomTextForm(
                                        controller: senhaControl,
                                        icon: Icons.lock,
                                        label: 'Senha',
                                        isSecret: true,
                                      ),
                                      CustomTextForm(
                                        controller: nomeControl,
                                        icon: Icons.person,
                                        label: 'Nome',
                                      ),
                                      CustomTextForm(
                                        isSecret: false,
                                        controller: idadeControl,
                                        icon: Icons.calendar_month,
                                        label: 'Nascimento',
                                        maskType: [widget.idadeMask],
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                      ),
                                      CustomTextForm(
                                        controller: cpfControl,
                                        icon: Icons.description,
                                        label: 'CPF',
                                        maskType: [widget.cpfMask],
                                        keyType:
                                            TextInputType.numberWithOptions(),
                                      ),
                                      CustomTextForm(
                                        controller: parentescoControl,
                                        icon: Icons.family_restroom,
                                        label: 'Parentesco',
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
                                                  emailControl
                                                      .text.isNotEmpty &&
                                                  senhaControl
                                                      .text.isNotEmpty &&
                                                  idadeControl
                                                      .text.isNotEmpty &&
                                                  cpfControl.text.isNotEmpty) {
                                                var uid = FirebaseAuth
                                                    .instance.currentUser?.uid;
                                                print('ID CADASTRADO: $uid');
                                                await FirebaseFirestore.instance
                                                    .collection('Usuarios')
                                                    .doc(widget.uid.toString())
                                                    .update({
                                                  'uid': uid.toString(),
                                                  'nome': nomeControl.text,
                                                  'email': emailControl.text,
                                                  'senha': senhaControl.text,
                                                  'idade': idadeControl.text,
                                                  'cpf': cpfControl.text,
                                                  'parentesco':
                                                      parentescoControl.text,
                                                  'foto': fotoLocal,
                                                });
                                                await FirebaseFirestore.instance
                                                    .collection('Usuarios')
                                                    .doc(uid.toString())
                                                    .collection('Criancas')
                                                    .doc(widget.uid)
                                                    .update({
                                                  'uid': uid.toString(),
                                                  'nome': nomeControl.text,
                                                  'email': emailControl.text,
                                                  'senha': senhaControl.text,
                                                  'idade': idadeControl.text,
                                                  'cpf': cpfControl.text,
                                                  'parentesco':
                                                      parentescoControl.text,
                                                  'foto': fotoLocal,
                                                  'tokenRes': mtoken,
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
                                                  emailControl.clear();
                                                  senhaControl.clear();
                                                  idadeControl.clear();
                                                  cpfControl.clear();
                                                  parentescoControl.clear();
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
                                                          'Erro ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
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
                                                        'Erro ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )));
                                            }
                                          },
                                          child: Text(
                                            'Atualizar Dados',
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
    DocumentSnapshot tokenRes = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      mtoken = tokenRes['token'];
    });
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
      fotoLocal = docRef['foto'];
    });
  }
}
