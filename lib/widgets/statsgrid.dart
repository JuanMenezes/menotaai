import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class statsgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.deepPurple,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Aprovgeral2017')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var totalalu = snapshot.data!.docs[3]['alunos'];
              var totalaprov = snapshot.data!.docs[2]['Aprovados'];
              var totalrep = snapshot.data!.docs[2]['Reprovados'];
              var totalesc = snapshot.data!.docs[3]['Escolas'];
              return Column(children: <Widget>[
                Flexible(
                    child: Row(
                  children: <Widget>[
                    _buildcard('Taxa de Aprovação', totalaprov.toString() + '%',
                        Colors.green),
                    _buildcard("Taxa de Reprovação", totalrep.toString() + '%',
                        Colors.red)
                  ],
                )),
                Flexible(
                    child: Row(
                  children: <Widget>[
                    _buildcard(
                        'Total de alunos', totalalu.toString(), Colors.orange),
                    _buildcard("Total de Escolas", totalesc.toString(),
                        Colors.lightBlue),
                  ],
                ))
              ]);
            } else {
              return const Text('Loading...');
            }
          }),
    );
  }

  Expanded _buildcard(String title, String count, MaterialColor color) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(count,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600))
          ]),
    ));
  }
}
