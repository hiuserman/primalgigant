import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:bookapp/models/book.dart';

class Book{
  final String? title;
  final List<String>? author;
  final String? description;
  final String? imageUrl;
  final String? publishedDate;
  final String? publisher;

  Book({
    this.title,
    this.author,
    this.description,
    this.imageUrl,
    this.publishedDate,
    this.publisher,
  });

factory Book.fromJson(Map<String, dynamic> json) {
  return Book(
    title: json['title'],
    author: json['authors'] != null ? List<String>.from(json['authors']) : null,
    description: json['description'],
    imageUrl: json['thumbnail']?.replaceFirst('http://', 'https://'),
    publishedDate: json['publishedDate'],
    publisher: json['publisher'],
  );
}
}

Future<Book?> fetchBook(String isbn) async {
  final url = Uri.parse('http://127.0.0.1:8000/api/decode?isbn=$isbn');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return Book.fromJson(data);
  } else {
    throw Exception('Failed to load book');
  }
}



