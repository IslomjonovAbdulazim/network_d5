import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_d5/models/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PostModel> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    setState(() => isLoading = true);
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final list = List.from(body);
        posts = list.map((j) => PostModel.fromJson(j)).toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final model = posts[index];
          return ListTile(
            title: Text(model.title),
            subtitle: Text(model.body),
          );
        },
      ),
    );
  }
}
