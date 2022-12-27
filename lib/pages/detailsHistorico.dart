import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meudentinho/config.dart';

class DetailsHistorico extends StatefulWidget {
  String uid;
  String data;
  String hora1;
  String foto1;
  String hora2;
  String foto2;
  String hora3;
  String foto3;
  String feito1;
  String feito2;
  String feito3;
  int pontosatuais;
  DetailsHistorico({
    Key? key,
    this.pontosatuais = 0,
    this.uid = '',
    this.data = '',
    this.hora1 = '',
    this.foto1 = '',
    this.hora2 = '',
    this.foto2 = '',
    this.hora3 = '',
    this.foto3 = '',
    this.feito1 = 'pendente',
    this.feito2 = 'pendente',
    this.feito3 = 'pendente',
  }) : super(key: key);

  @override
  State<DetailsHistorico> createState() => _DetailsHistoricoState();
}

class _DetailsHistoricoState extends State<DetailsHistorico> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.foto2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Data: ${widget.data}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1º Escovação: ${widget.hora1}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.size.height * 0.5,
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [shadow],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.foto1),
                        ),
                      ),
                    ),
                  ),
                  if (widget.feito1 == 'pendente')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: titulo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            var data = widget.data;
                            data = data.replaceAll('/', '');
                            //
                            try {
                              await FirebaseFirestore.instance
                                  .collection('Usuarios')
                                  .doc(widget.uid)
                                  .collection('Escovacao')
                                  .doc('1')
                                  .update({'feita': 'sim'});
                              //
                              await FirebaseFirestore.instance
                                  .collection('Historico')
                                  .doc(widget.uid)
                                  .collection('Historico')
                                  .doc(data)
                                  .update({
                                'qtd': '1',
                                'time1': 'sim',
                              });
                              setState(() {
                                widget.feito1 = 'sim';
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('Validar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            var data = widget.data;
                            data = data.replaceAll('/', '');

                            try {
                              await FirebaseFirestore.instance
                                  .collection('Usuarios')
                                  .doc(widget.uid)
                                  .collection('Escovacao')
                                  .doc('1')
                                  .update({'feita': 'não'});
                              //
                              await FirebaseFirestore.instance
                                  .collection('Historico')
                                  .doc(widget.uid)
                                  .collection('Historico')
                                  .doc(data)
                                  .update({
                                'qtd': '0',
                                'time1': 'não',
                              });
                              var ponto = await widget.pontosatuais - 1;
                              await FirebaseFirestore.instance
                                  .collection('Usuarios')
                                  .doc(widget.uid)
                                  .collection('Meta')
                                  .doc('Meta')
                                  .update({'pontosatuais': ponto});
                              await FirebaseFirestore.instance
                                  .collection('Usuarios')
                                  .doc(widget.uid)
                                  .update({'pontos': ponto});
                              await Future.delayed(Duration(seconds: 2));
                              setState(() {
                                widget.feito1 = 'não';
                              });
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('Inválidar'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            widget.foto2 != '' || widget.foto2.isNotEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Data: ${widget.data}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2º Escovação: ${widget.hora2}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: Get.size.height * 0.8,
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [shadow],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.foto2),
                            ),
                          ),
                        ),
                        if (widget.feito2 == 'pendente')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: titulo,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () async {
                                  var data = widget.data;
                                  data = data.replaceAll('/', '');
                                  //
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Usuarios')
                                        .doc(widget.uid)
                                        .collection('Escovacao')
                                        .doc('2')
                                        .update({'feita': 'sim'});
                                    //
                                    await FirebaseFirestore.instance
                                        .collection('Historico')
                                        .doc(widget.uid)
                                        .collection('Historico')
                                        .doc(data)
                                        .update({
                                      'qtd': '2',
                                      'time2': 'sim',
                                    });
                                    setState(() {
                                      widget.feito2 = 'sim';
                                    });
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text('Validar'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () async {
                                  var data = widget.data;
                                  data = data.replaceAll('/', '');

                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Usuarios')
                                        .doc(widget.uid)
                                        .collection('Escovacao')
                                        .doc('2')
                                        .update({'feita': 'não'});
                                    //
                                    await FirebaseFirestore.instance
                                        .collection('Historico')
                                        .doc(widget.uid)
                                        .collection('Historico')
                                        .doc(data)
                                        .update({
                                      'qtd': '1',
                                      'time2': 'não',
                                    });
                                    var ponto = await widget.pontosatuais - 1;
                                    await FirebaseFirestore.instance
                                        .collection('Usuarios')
                                        .doc(widget.uid)
                                        .collection('Meta')
                                        .doc('Meta')
                                        .update({'pontosatuais': ponto});
                                    await FirebaseFirestore.instance
                                        .collection('Usuarios')
                                        .doc(widget.uid)
                                        .update({'pontos': ponto});
                                    await Future.delayed(Duration(seconds: 2));
                                    setState(() {
                                      widget.feito2 = 'não';
                                    });
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text('Inválidar'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.red,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Escovação Diária Incompleta!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
            if (widget.foto3 != '')
              widget.foto3 != ''
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Data: ${widget.data}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '3º Escovação: ${widget.hora3}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: Get.size.height * 0.8,
                            width: Get.size.width,
                            decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [shadow],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.foto3),
                              ),
                            ),
                          ),
                          if (widget.feito3 == 'pendente')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: titulo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () async {
                                    var data = widget.data;
                                    data = data.replaceAll('/', '');
                                    //
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('Usuarios')
                                          .doc(widget.uid)
                                          .collection('Escovacao')
                                          .doc('3')
                                          .update({'feita': 'sim'});
                                      //
                                      await FirebaseFirestore.instance
                                          .collection('Historico')
                                          .doc(widget.uid)
                                          .collection('Historico')
                                          .doc(data)
                                          .update({
                                        'qtd': '3',
                                        'time3': 'sim',
                                      });
                                      setState(() {
                                        widget.feito3 = 'sim';
                                      });
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text('Validar'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () async {
                                    var data = widget.data;
                                    data = data.replaceAll('/', '');

                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('Usuarios')
                                          .doc(widget.uid)
                                          .collection('Escovacao')
                                          .doc('3')
                                          .update({'feita': 'não'});
                                      //
                                      await FirebaseFirestore.instance
                                          .collection('Historico')
                                          .doc(widget.uid)
                                          .collection('Historico')
                                          .doc(data)
                                          .update({
                                        'qtd': '2',
                                        'time3': 'não',
                                      });
                                      var ponto = await widget.pontosatuais - 1;
                                      await FirebaseFirestore.instance
                                          .collection('Usuarios')
                                          .doc(widget.uid)
                                          .collection('Meta')
                                          .doc('Meta')
                                          .update({'pontosatuais': ponto});
                                      await FirebaseFirestore.instance
                                          .collection('Usuarios')
                                          .doc(widget.uid)
                                          .update({'pontos': ponto});
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      setState(() {
                                        widget.feito3 = 'não';
                                      });
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text('Inválidar'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.red,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Escovação Diária Incompleta!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
          ],
        ),
      ),
    );
  }
}
