import 'package:flutter/foundation.dart';

class BookListModel {
  String? id;
  String? author;
  String? bookName;
  String? bookUrl;
  String? category;
  String? bookDesc;
  String? date;

  BookListModel({
    this.id,
    this.author,
    this.bookName,
    this.bookUrl,
    this.category,
    this.bookDesc,
    this.date,
  });

  factory BookListModel.fromJson(Map<String, dynamic> json) {
    return BookListModel(
      id: json['id'],
      author: json['book_author'],
      bookName: json['book_name'],
      bookUrl: json['book_url'],
      category: json['category'],
      bookDesc: json['description'],
      date: json['date'],
    );
  }
}
