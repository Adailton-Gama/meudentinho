import 'package:flutter/material.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/pages/signupscreen.dart';
import '../componentes/customtextForm.dart';

class EscolherConta extends StatefulWidget {
  const EscolherConta({Key? key}) : super(key: key);

  @override
  State<EscolherConta> createState() => _EscolherContaState();
}

class _EscolherContaState extends State<EscolherConta> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padBottom = MediaQuery.of(context).padding.bottom;
    var padTop = MediaQuery.of(context).padding.top;
    var padTotal = padTop + padBottom;
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - padTotal,
            width: size.width,
            child: SafeArea(
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
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Junte-se a Nós',
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

                  //Formulário
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(size.width * 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpScreen(tipo: 'dentista'),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [shadow],
                                  gradient: gradient,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/icondentista.png'),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sou um',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Dentista',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpScreen(tipo: 'responsavel'),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [shadow],
                                  gradient: gradient,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        invertColors: true,
                                        image: AssetImage(
                                            'assets/images/paiefilha.png'),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sou um',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Responsável',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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
        ),
      ),
    );
  }
}
