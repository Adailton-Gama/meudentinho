import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meudentinho/componentes/customtextForm.dart';
import 'package:meudentinho/config.dart';

class ResetSenha extends StatefulWidget {
  const ResetSenha({Key? key}) : super(key: key);

  @override
  State<ResetSenha> createState() => _ResetSenhaState();
}

class _ResetSenhaState extends State<ResetSenha> {
  TextEditingController emailControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: background,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/resetpass.png'),
                  ),
                ),
              ),
              Text(
                'Esqueceu sua Senha?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              Text(
                'Digite abaixo o e-mail cadastrado para recuperar sua senha!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              CustomTextForm(
                icon: Icons.mail,
                label: 'E-mail',
                controller: emailControl,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailControl.text != null) {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailControl.text);
                        //
                        // print('Recuperar Senha');
                        //
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Redefinição de Senha enviada por e-mail!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                        setState(() {
                          emailControl.clear();
                        });
                        //
                        //
                        Navigator.pop(context);
                        FirebaseAuth.instance.signOut();
                      } on FirebaseException catch (e) {
                        print(e.code);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              'Erro ao enviar e-mail, verifique se foi digitado corretamente!',
                              textAlign: TextAlign.center,
                            )));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Recuperar Senha',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
