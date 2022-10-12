import 'package:e_library/screens/category/science_category.dart';
import 'package:flutter/material.dart';

class BookCategory extends StatefulWidget {
  const BookCategory({Key? key}) : super(key: key);

  @override
  State<BookCategory> createState() => _BookCategoryState();
}

class _BookCategoryState extends State<BookCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 120,
              maxCrossAxisExtent: 160,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const BookCategoryList(category: 'engineering');
              }));
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
Text("Engineering"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
