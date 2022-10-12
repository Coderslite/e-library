import 'package:e_library/screens/book_detail.dart';
import 'package:flutter/material.dart';

class BookCategoryList extends StatefulWidget {
  final String category;
  const BookCategoryList({Key? key, required this.category}) : super(key: key);

  @override
  State<BookCategoryList> createState() => _BookCategoryListState();
}

class _BookCategoryListState extends State<BookCategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                  Text("${widget.category} Books Store"),
                  const Icon(Icons.search),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              for (int x = 0; x < 10; x++)
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return const BookDetails();
                    // }));
                  },
                  child: ListTile(
                    leading: Image.network(
                      "https://th.bing.com/th/id/R.b1ed381a19dbbdbc3b880f8d3d17e296?rik=vr8AmEXmp%2b3hzA&pid=ImgRaw&r=0",
                      fit: BoxFit.cover,
                    ),
                    title: const Text("The far cry"),
                    subtitle: const Text("Chinua Achebe"),
                    trailing: const Icon(Icons.download),
                  ),
                )
            ],
          ),
        ),
      )),
    );
  }
}
