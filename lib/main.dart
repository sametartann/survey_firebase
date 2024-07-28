import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Survey'),
        ),
        body: SurveyList(),
      ),
    );
  }
}

class SurveyList extends StatefulWidget {
  @override
  State<SurveyList> createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("languagesurvey").snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return LinearProgressIndicator();
          } else{
            return buildBody(context, snapshot.data!.docs);
          }
        }
    );
  }

  Widget buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map<Widget>((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final row = Survey.fromSnapshot(data);
    return Padding(
      key: ValueKey(row.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(row.name),
          trailing: Text(row.vote.toString()),
          onTap: () => FirebaseFirestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(row.reference!);
            final fresh = Survey.fromSnapshot(freshSnapshot);
            await transaction.update(row.reference!, {'vote': fresh.vote + 1});
          }),
        ),
      ),
    );
  }
}

final fakeSnapshot = [
  {"name": "C", "vote": "3"},
  {"name": "Java", "vote": "4"},
  {"name": "Dart", "vote": "5"},
  {"name": "C++", "vote": "7"},
  {"name": "Python", "vote": "60"},
  {"name": "C#", "vote": "2"},
];

class Survey {
  final String name;
  final int vote;
  final DocumentReference? reference;

  Survey.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['vote'] != null),
        name = map['name'],
        vote = map['vote'];

  Survey.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);
}
