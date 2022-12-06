import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
Color titulo = Color.fromRGBO(18, 156, 183, 1);
//
Color background = Color.fromRGBO(39, 187, 215, 1);
//
Color secondary = Color.fromRGBO(16, 88, 152, 1);
//
Color backBar = Color.fromRGBO(22, 222, 246, 1);
//
Color frontBar = Color.fromRGBO(18, 156, 183, 1);
//
Color backVerde = Color.fromRGBO(223, 239, 12, 1);
//
Color shadowColor = Colors.black.withAlpha(100);
//
Gradient gradient = LinearGradient(colors: [
  Color.fromRGBO(18, 156, 183, 1),
  Color.fromRGBO(90, 222, 246, 1),
]);
//
Gradient gradientSair = LinearGradient(colors: [
  Color.fromRGBO(255, 0, 0, 1),
  Color.fromRGBO(244, 97, 97, 1),
]);
//
BoxShadow shadow = BoxShadow(
  color: shadowColor,
  blurRadius: 8,
  spreadRadius: 2,
);
//
Drawer menu = Drawer(
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
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePage(uid: FirebaseAuth.instance.currentUser!.uid)),
                          //     (route) => false);
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
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => MinhaEscovacao()),
                          //     (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: gradient,
                          ),
                          child: Text('Minha Escovação',
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
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => MetaDiaria()),
                          //     (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: gradient,
                          ),
                          child: Text('Meta Diária',
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
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => NossaHistoria()),
                          //     (route) => false);
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
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => Especialistas()),
                          //     (route) => false);
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
            onTap: () {
              // ScaffoldMessenger.of(context).clearSnackBars();
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     backgroundColor: Colors.redAccent,
              //     content: Text(
              //       'Saindo da Conta...',
              //       textAlign: TextAlign.center,
              //     )));
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => HomePage(uid: FirebaseAuth.instance.currentUser!.uid)),
              //     (route) => false);
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
);
