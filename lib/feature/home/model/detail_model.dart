import 'package:cloud_firestore/cloud_firestore.dart';

class DetailModel {
  final String? name;
  final String? email;
  final int? number;
  final int? age;
  final String? id;
  DetailModel({
    this.name,
    this.email,
    this.number,
    this.age,
    this.id,
  });

  factory DetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    return DetailModel(
      name: snap.data()?['name'],
      email: snap.data()?['email'],
      number: snap.data()?['number'],
      age: snap.data()?['age'],
      id: snap.data()?['id'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      "name": name,
      "email": email,
      "number": number,
      "age": age,
      "id": id,
    };
  }
}
