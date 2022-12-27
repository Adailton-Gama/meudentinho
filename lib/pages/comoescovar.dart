import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/pages/startScreen.dart';
import 'package:video_player/video_player.dart';

import '../config.dart';
import '../homepage.dart';
import 'especialistas.dart';
import 'metadiaria.dart';
import 'nossahistoria.dart';

class ComoEscovar extends StatefulWidget {
  const ComoEscovar({Key? key}) : super(key: key);

  @override
  State<ComoEscovar> createState() => _ComoEscovarState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _ComoEscovarState extends State<ComoEscovar> {
  VideoPlayerController controller =
      VideoPlayerController.asset('assets/video/comoescovar.mp4');
  String sexo = 'Menino';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        });
      });
    }
    controller.addListener(() => setState(() {}));
    controller.setLooping(false);
    controller.initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double cardWidth = Get.size.width * 0.9;
    double tamanhobarra = cardWidth - 30;

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
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid)),
                                    (route) => false);
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
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient,
                                ),
                                child: Text(
                                  'Como escova meu dentinho',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
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
        title: Text('Como escovar meu dentinho'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                //Dados da Criança
                GestureDetector(
                  onTap: () => controller.value.isPlaying
                      ? controller.pause()
                      : controller.play(),
                  child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: Stack(children: [
                        VideoPlayer(controller),
                        Align(
                          alignment: Alignment.center,
                          child: controller.value.isPlaying
                              ? Container()
                              : Container(
                                  height: 80,
                                  width: 80,
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 80,
                                    color: sexo == 'Menino'
                                        ? backBar
                                        : secondaryRosa,
                                  ),
                                ),
                        )
                      ])),
                ),
                Container(
                  height: 15,
                  width: Get.size.width * 0.9,
                  child: VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: sexo == 'Menino' ? titulo : secondaryRosa,
                      backgroundColor:
                          sexo == 'Menino' ? backBar : backgroundRosa,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Como escovar meu dentinho?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: sexo == 'Menino' ? secondary : secondaryRosa,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '''1º Agora daremos início a escovação;

2º Encoste as cerdas da escova na região entre a gengiva e os dentes;

3º Sempre fazendo movimentos circulares;

4º Para limpar a parte de cima dos dentes deve-se fazer um movimento de vai-e-vem;

5º Nessa região devemos fazer o movimento de "Vassourinha";

6º Repetimos o movimento de "vassourinha" na arcada superior;

7º Repita o mesmo processo em todos os dentes;

8º Para escovar a língua faça movimentos para trás e para frente;''',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
