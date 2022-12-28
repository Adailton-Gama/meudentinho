import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/homepage.dart';
import 'package:meudentinho/pages/teladentista.dart';
import '../componentes/customtextForm.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.tipo}) : super(key: key);
  String tipo;
  final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
  final phoneMask = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {'#': RegExp(r'[0-9]')});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final CollectionReference refUser =
      FirebaseFirestore.instance.collection('Usuarios');
  TextEditingController emailControl = TextEditingController();
  TextEditingController senhaControl = TextEditingController();
  TextEditingController nomeControl = TextEditingController();
  TextEditingController celularControl = TextEditingController();
  TextEditingController cpfControl = TextEditingController();
  TextEditingController croControl = TextEditingController();
  String adminEmail = '';
  String adminPass = '';
  String selectedValue = 'Menino';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmailAdmin();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padBottom = MediaQuery.of(context).padding.bottom;
    var padTop = MediaQuery.of(context).padding.top;
    var padTotal = padTop + padBottom;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Container(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),

              //Título
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: widget.tipo != 'responsavel'
                      ? Container(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                DropdownButtonFormField(
                                  elevation: 0,
                                  dropdownColor: background,
                                  borderRadius: BorderRadius.circular(20),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Menino'),
                                      value: 'Menino',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Menina'),
                                      value: 'Menina',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  value: selectedValue,
                                ),
                                SizedBox(height: 15),
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
                                CustomTextForm(
                                  controller: croControl,
                                  icon: Icons.description,
                                  label: 'CRO',
                                  maskType: [widget.cpfMask],
                                  keyType: TextInputType.numberWithOptions(),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (FirebaseAuth
                                              .instance.currentUser?.uid ==
                                          null) {
                                        try {
                                          if (nomeControl.text != null &&
                                              emailControl.text != null &&
                                              senhaControl.text != null &&
                                              celularControl.text != null &&
                                              cpfControl.text != null &&
                                              croControl.text != null) {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                              email: emailControl.text,
                                              password: senhaControl.text,
                                            );

                                            var uid = FirebaseAuth
                                                .instance.currentUser?.uid;
                                            print('ID CADASTRADO: $uid');
                                            await FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(uid.toString())
                                                .set({
                                              'uid': uid.toString(),
                                              'nome': nomeControl.text,
                                              'email': emailControl.text,
                                              'senha': senhaControl.text,
                                              'telefone': celularControl.text,
                                              'cpf': cpfControl.text,
                                              'cro': croControl.text,
                                              'nivel': widget.tipo,
                                              'sexo': selectedValue,
                                              'foto':
                                                  'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975',
                                              'dtcadastro': Timestamp.now(),
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
                                              celularControl.clear();
                                              cpfControl.clear();
                                              croControl.clear();
                                            });
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TelaDentista(
                                                                uid: uid
                                                                    .toString())),
                                                    (route) => false);
                                          }
                                        } on FirebaseException catch (e) {
                                          print(e.message);
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  )));
                                        }
                                      } else {
                                        await FirebaseAuth.instance.signOut();
                                        try {
                                          if (nomeControl.text != null &&
                                              emailControl.text != null &&
                                              senhaControl.text != null &&
                                              celularControl.text != null &&
                                              cpfControl.text != null &&
                                              croControl.text != null) {
                                            FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                              email: emailControl.text,
                                              password: senhaControl.text,
                                            );
                                            await Future.delayed(
                                                Duration(seconds: 3));
                                            print(
                                                'ID CADASTRADO: ${FirebaseAuth.instance.currentUser?.uid}');
                                            FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser?.uid
                                                    .toString())
                                                .set({
                                              'nome': nomeControl.text,
                                              'email': emailControl.text,
                                              'senha': senhaControl.text,
                                              'celular': celularControl.text,
                                              'cpf': cpfControl.text,
                                              'cro': croControl.text,
                                              'nivel': widget.tipo,
                                              'sexo': selectedValue,
                                              'foto':
                                                  'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975',
                                              'dtcadastro': Timestamp.now(),
                                            });
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Usuário: ${nomeControl.text} cadastrado com sucesso!'),
                                              ),
                                            );
                                            setState(() {
                                              nomeControl.clear();
                                              emailControl.clear();
                                              senhaControl.clear();
                                              celularControl.clear();
                                              cpfControl.clear();
                                              croControl.clear();
                                            });

                                            Future.delayed(Duration(seconds: 1))
                                                .then((value) {
                                              FirebaseAuth.instance.signOut();
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: adminEmail,
                                                      password: adminPass);
                                            });
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TelaDentista(
                                                                uid: FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)),
                                                    (route) => false);
                                          }
                                        } on FirebaseException catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  )));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Cadastrar usuário',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                DropdownButtonFormField(
                                  elevation: 0,
                                  dropdownColor: background,
                                  borderRadius: BorderRadius.circular(20),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Menino'),
                                      value: 'Menino',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Menina'),
                                      value: 'Menina',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  value: selectedValue,
                                ),
                                SizedBox(height: 15),
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
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (FirebaseAuth
                                              .instance.currentUser?.uid ==
                                          null) {
                                        try {
                                          if (nomeControl.text != null &&
                                              emailControl.text != null &&
                                              senhaControl.text != null &&
                                              celularControl.text != null &&
                                              cpfControl.text != null &&
                                              croControl.text != null) {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                              email: emailControl.text,
                                              password: senhaControl.text,
                                            );

                                            var uid = FirebaseAuth
                                                .instance.currentUser?.uid;
                                            print('ID CADASTRADO: $uid');
                                            await FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(uid.toString())
                                                .set({
                                              'uid': uid.toString(),
                                              'nome': nomeControl.text,
                                              'email': emailControl.text,
                                              'senha': senhaControl.text,
                                              'telefone': celularControl.text,
                                              'cpf': cpfControl.text,
                                              'cro': croControl.text,
                                              'nivel': widget.tipo,
                                              'sexo': selectedValue,
                                              'foto':
                                                  'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975',
                                              'dtcadastro': Timestamp.now(),
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
                                              celularControl.clear();
                                              cpfControl.clear();
                                              croControl.clear();
                                            });
                                          }
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)),
                                                  (route) => false);
                                        } on FirebaseException catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  )));
                                        }
                                      } else {
                                        await FirebaseAuth.instance.signOut();
                                        try {
                                          if (nomeControl.text != null &&
                                              emailControl.text != null &&
                                              senhaControl.text != null &&
                                              celularControl.text != null &&
                                              cpfControl.text != null) {
                                            FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                              email: emailControl.text,
                                              password: senhaControl.text,
                                            );
                                            await Future.delayed(
                                                Duration(seconds: 3));
                                            print(
                                                'ID CADASTRADO: ${FirebaseAuth.instance.currentUser?.uid}');
                                            FirebaseFirestore.instance
                                                .collection('Usuarios')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser?.uid
                                                    .toString())
                                                .set({
                                              'nome': nomeControl.text,
                                              'email': emailControl.text,
                                              'senha': senhaControl.text,
                                              'celular': celularControl.text,
                                              'cpf': cpfControl.text,
                                              'nivel': widget.tipo,
                                              'sexo': selectedValue,
                                              'foto':
                                                  'https://firebasestorage.googleapis.com/v0/b/meudentinho-57d84.appspot.com/o/add_foto.png?alt=media&token=a6cc94f0-bb00-4b2a-8b6d-655c679f1975',
                                              'dtcadastro': Timestamp.now(),
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
                                              celularControl.clear();
                                              cpfControl.clear();
                                            });

                                            Future.delayed(Duration(seconds: 1))
                                                .then((value) {
                                              FirebaseAuth.instance.signOut();
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: adminEmail,
                                                      password: adminPass);
                                            });
                                          }
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)),
                                                  (route) => false);
                                        } on FirebaseException catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Error ao se cadastrar\nVerifique se todos os campos estão preenchidos!',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  )));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Cadastrar usuário',
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
                ),
              ),
              //Formulário
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
}
