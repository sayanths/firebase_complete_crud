import 'package:cloud_firestore/cloud_firestore.dart';

class DetailModel {
  final String? name;
  final String? email;
  final int? number;
  final int? age;
  

  DetailModel({
    this.name,
    this.email,
    this.number,
    this.age,
  });

  factory DetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    return DetailModel(
      name: snap.data()?['name'],
      email: snap.data()?['email'],
      number: snap.data()?['number'],
      age: snap.data()?['age'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      "name": name,
      "email": email,
      "number": number,
      "age": age,
    };
  }
}
