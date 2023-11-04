import 'package:cloud_firestore/cloud_firestore.dart';

class DetailModel {
  final String? postTitle;
  final String ?brandName;
  final String? yearsUsed;
  final String? resonForSelling;
  final String? description;
  final String? uploadedDate;

  DetailModel({
     this.postTitle,
     this.brandName,
     this.yearsUsed,
     this.resonForSelling,
     this.description,
     this.uploadedDate,
  });

  factory DetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    return DetailModel(
      postTitle: snap.data()?['postTitle'],
      brandName: snap.data()?['brandName'],
      yearsUsed: snap.data()?['yearsUsed'],
      resonForSelling: snap.data()?['resonForSelling'],
      description: snap.data()?['description'],
      uploadedDate: snap.data()?['uploadedDate'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      "postTitle": postTitle,
      "brandName": brandName,
      "yearsUsed": yearsUsed,
      "resonForSelling": resonForSelling,
      "description": description,
      "uploadedDate": uploadedDate,
    };
  }
}
