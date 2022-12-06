import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meudentinho/pages/telaresponsavel.dart';

import '../componentes/customtextForm.dart';
import '../config.dart';
import '../homepage.dart';

class EditarResponsavel extends StatefulWidget {
  EditarResponsavel({Key? key}) : super(key: key);
  final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
  final phoneMask = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {'#': RegExp(r'[0-9]')});
  @override
  State<EditarResponsavel> createState() => _EditarResponsavelState();
}

class _EditarResponsavelState extends State<EditarResponsavel> {
  PickedFile? foto;
  String _foto = '';

  String fotoLocal =
      'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975';
  //
  TextEditingController emailControl = TextEditingController();
  TextEditingController senhaControl = TextEditingController();
  TextEditingController nomeControl = TextEditingController();
  TextEditingController celularControl = TextEditingController();
  TextEditingController cpfControl = TextEditingController();
  TextEditingController croControl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padBottom = MediaQuery.of(context).padding.bottom;
    var padTop = MediaQuery.of(context).padding.top;
    var padTotal = padTop + padBottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: Text('Editar Perfil'),
      ),
      body: Container(
        height: Get.size.height,
        width: Get.size.width,
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(size.width * 0.1),
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  final storage = FirebaseStorage.instance;

                  var ref = FirebaseFirestore.instance
                      .collection('Usuarios')
                      .doc(FirebaseAuth.instance.currentUser!.uid);

                  PickedFile? fotoPerfil =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  var file = File(fotoPerfil!.path);
                  var cadFoto = await storage
                      .ref()
                      .child(
                          'usuarios/${FirebaseAuth.instance.currentUser!.uid}/foto/perfil/')
                      .putFile(file);
                  //
                  var imgUrl = await cadFoto.ref.getDownloadURL();
                  //
                  ref.update({
                    'foto': imgUrl,
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(100),
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
                controller: nomeControl,
                icon: Icons.person,
                label: 'Nome',
              ),
              CustomTextForm(
                controller: celularControl,
                icon: Icons.phone,
                label: 'Celular',
                maskType: [widget.phoneMask],
                keyType: TextInputType.numberWithOptions(),
              ),
              CustomTextForm(
                controller: cpfControl,
                icon: Icons.description,
                label: 'CPF',
                maskType: [widget.cpfMask],
                keyType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 50,
                width: Get.size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      if (nomeControl.text != null &&
                          emailControl.text != null &&
                          celularControl.text != null &&
                          cpfControl.text != null) {
                        var uid = FirebaseAuth.instance.currentUser?.uid;
                        print('ID CADASTRADO: $uid');
                        await FirebaseFirestore.instance
                            .collection('Usuarios')
                            .doc(uid.toString())
                            .update({
                          'uid': uid.toString(),
                          'nome': nomeControl.text,
                          'email': emailControl.text,
                          'telefone': celularControl.text,
                          'cpf': cpfControl.text,
                          'foto': fotoLocal,
                          'nivel': 'responsavel',
                        });
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'Usuário: ${nomeControl.text} cadastrado com sucesso!')));
                        setState(() {
                          nomeControl.clear();
                          emailControl.clear();
                          celularControl.clear();
                          cpfControl.clear();
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    TelaResponsavel(uid: uid.toString())),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Erro ao Atualizar\nVerifique se todos os campos estão preenchidos!',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )));
                      }
                    } on FirebaseException catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Erro ao atualizar os dados\nVerifique se todos os campos estão preenchidos!',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
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
    );
  }

  void getData() async {
    DocumentSnapshot docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      nomeControl.text = docRef['nome'];
      emailControl.text = docRef['email'];
      celularControl.text = docRef['telefone'];
      cpfControl.text = docRef['cpf'];
      fotoLocal = docRef['foto'];
    });
  }
}
