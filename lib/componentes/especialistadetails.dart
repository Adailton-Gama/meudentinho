import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meudentinho/config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/itemModel.dart';

class EspecialistaDetails extends StatefulWidget {
  String uid;
  String imgUrl;
  EspecialistaDetails({Key? key, required this.uid, required this.imgUrl})
      : super(key: key);

  @override
  State<EspecialistaDetails> createState() => EespecialistDdetailsState();
}

class EespecialistDdetailsState extends State<EspecialistaDetails> {
  @override
  int itemCount = 1;
  String nome = '';
  String especializacao = '';
  String locais = '';
  String descricao = '';
  String whatsapp = '';
  String instagram = '';
  String foto = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
            child: Row(
              children: [
                Hero(
                  tag: widget.imgUrl,
                  child: Image.network(
                    widget.imgUrl,
                    height: size.height * .4,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      especializacao,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: size.height * .4,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                boxShadow: [shadow],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              especializacao,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              locais,
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 10,
                      width: Get.size.width,
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sobre mim',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              descricao,
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Contato:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String telefone = whatsapp;
                                    telefone.replaceAll('(', '');
                                    telefone.replaceAll(')', '');
                                    telefone.replaceAll(' ', '');
                                    telefone.replaceAll('-', '');
                                    _launcheInApp('https://wa.me/55$telefone');
                                  },
                                  child: Container(
                                    width: 107,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    decoration: BoxDecoration(
                                      color: background,
                                      boxShadow: [shadow],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/whatsapp.png'))),
                                        ),
                                        Text(
                                          'WhatsApp',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var newlink = instagram.replaceAll('@', '');
                                    _launcheInApp(
                                        'https://www.instagram.com/$newlink/');
                                  },
                                  child: Container(
                                    width: 107,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    decoration: BoxDecoration(
                                      color: background,
                                      boxShadow: [shadow],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: EdgeInsets.all(10),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/instagram.png'))),
                                        ),
                                        Text(
                                          'Instagram',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void getData() async {
    var docRef = await FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(widget.uid)
        .collection('Perfil')
        .get()
        .then((value) {
      setState(() {
        nome = value.docs[0]['nome'];
        especializacao = value.docs[0]['especializacao'];
        locais = value.docs[0]['locais'];
        descricao = value.docs[0]['descricao'];
        whatsapp = value.docs[0]['whatsapp'];
        instagram = value.docs[0]['instagram'];
      });
    });
  }

  Future<void> _launcheInApp(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
