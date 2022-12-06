import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:meudentinho/config.dart';
import 'package:meudentinho/homepage.dart';
import 'package:meudentinho/pages/escolherconta.dart';
import 'package:meudentinho/pages/redefinirsenha.dart';
import 'package:meudentinho/pages/signupscreen.dart';
import 'package:meudentinho/pages/teladentista.dart';
import 'package:meudentinho/pages/telaresponsavel.dart';

import '../componentes/customtextForm.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    requestPermission();
    getToken();
    initInfo();
    checkUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    TextEditingController emailControl = TextEditingController();
    TextEditingController senhaControl = TextEditingController();

    return Scaffold(
      backgroundColor: backBar,
      body: Column(
        children: [
          Container(
            height: Get.size.height * 0.4,
            width: Get.size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/dentebranco.png'),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        'Meu Dentinho',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/icon/icon.png'),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 10,
              width: Get.size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Formulário
                    Container(
                      padding: EdgeInsets.all(Get.size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Get.size.width * 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Email
                          CustomTextForm(
                            controller: emailControl,
                            icon: Icons.email,
                            label: 'E-mail',
                          ),

                          //Senha
                          CustomTextForm(
                            controller: senhaControl,
                            label: 'Senha',
                            icon: Icons.lock,
                            isSecret: true,
                          ),

                          //Buttom Entrar
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailControl.text,
                                          password: senhaControl.text);
                                  await Future.delayed(Duration(seconds: 2));
                                  var uid =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  FirebaseFirestore.instance
                                      .collection('Usuarios')
                                      .doc(uid.toString())
                                      .get()
                                      .then((value) {
                                    String nivel = value['nivel'].toString();
                                    if (nivel == 'dentista') {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TelaDentista(
                                                      uid: FirebaseAuth.instance
                                                          .currentUser!.uid)));
                                    } else if (nivel == 'responsavel') {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TelaResponsavel(
                                                      uid: FirebaseAuth.instance
                                                          .currentUser!.uid)));
                                    } else if (nivel == 'crianca') {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                  uid: FirebaseAuth.instance
                                                      .currentUser!.uid)));
                                    }
                                  });
                                } on FirebaseException catch (error) {
                                  print(error);
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                            'Erro ao tentar fazer Login.',
                                            textAlign: TextAlign.center,
                                          )));
                                }
                              },
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          //Esqueceu a Senha
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResetSenha()));
                              },
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),

                          //Divisor
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Ou',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),

                          //Buttom Criar Conta
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 2,
                                  color: background,
                                ),
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            EscolherConta())));
                              },
                              child: Text(
                                'Criar Conta',
                                style: TextStyle(
                                  color: background,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Usuário Autorizado');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Usuário com permissão temporária');
    } else {
      print('Usuário com permissão negada');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('my token is $mtoken');
      });
      saveToken(token!);
    });
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("..............Messagem..............");
      print(
          "Messagem: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'lembrete',
        'lembrete',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const IOSNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'token': token,
    });
  }

  void checkUser() async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(uid)
          .get()
          .then((value) {
        String nivel = value['nivel'].toString();
        if (nivel == 'dentista') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => TelaDentista(
                      uid: FirebaseAuth.instance.currentUser!.uid)),
              (value) => false);
          print(
              '----------------------------$nivel----------------------------');
        } else if (nivel == 'responsavel') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => TelaResponsavel(
                      uid: FirebaseAuth.instance.currentUser!.uid)),
              (value) => false);
        } else if (nivel == 'crianca') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  HomePage(uid: FirebaseAuth.instance.currentUser!.uid)));
        }
        print('----------------------------$nivel----------------------------');
      });
    }
  }
}
