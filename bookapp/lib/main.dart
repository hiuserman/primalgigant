import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookLookupPage(),
    );
  }
}

class BookLookupPage extends StatefulWidget {
  @override
  _BookLookupPageState createState() => _BookLookupPageState();
}

class _BookLookupPageState extends State<BookLookupPage> {
  final _isbnController = TextEditingController();
  Book? _book;
  String? _error;

  void _search() async {
    final isbn = _isbnController.text.trim();
    final book = await fetchBook(isbn);
    setState(() {
      _book = book;
      _error = book == null ? "書籍が見つかりませんでした。" : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('書籍検索')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _isbnController,
              decoration: const InputDecoration(labelText: 'ISBNを入力'),
            ),
            ElevatedButton(
              onPressed: _search,
              child: const Text('検索'),
            ),
            if (_error != null) Text(_error!, style: TextStyle(color: Colors.red)),
            if (_book != null) ...[
              Text('タイトル: ${_book!.title}'),
              Text('著者: ${_book!.author?.join(", ")}'),
              Text('出版社: ${_book!.publisher}'),
              Text('出版日: ${_book!.publishedDate}'),
              if (_book!.imageUrl != null)
                Image.network(_book!.imageUrl!)
            ]
          ],
        ),
      ),
    );
  }
}