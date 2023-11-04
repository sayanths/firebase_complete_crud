import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/feature/home/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Posts'),
      ),
      body: Consumer<HomeController>(
        builder: (context, home, _) => 
       StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userProfile').doc(home.email).collection('cars')
            .where('emailId', isEqualTo: home.email)
            .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
      
            List<QueryDocumentSnapshot> posts = snapshot.data!.docs;
      
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var postData = posts[index].data() as Map<String, dynamic>;
                var title = postData['title'];
                var content = postData['content'];
      
                return ListTile(
                  title: Text(title),
                  subtitle: Text(content),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
