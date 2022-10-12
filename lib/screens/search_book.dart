import 'package:flutter/material.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({Key? key}) : super(key: key);

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 31, 44),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 61, 61, 80),
                  filled: true,
                  suffixIcon: const Icon(Icons.search),
                  hintText: "search books",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  )),
            ),
          ),
        ));
  }
}
