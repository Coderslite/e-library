import 'package:e_library/screens/book_detail.dart';
import 'package:flutter/material.dart';

class DownloadList extends StatefulWidget {
  const DownloadList({Key? key}) : super(key: key);

  @override
  State<DownloadList> createState() => _DownloadListState();
}

class _DownloadListState extends State<DownloadList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 31, 31, 44),
        body: ListView.builder(itemBuilder: (context, index) {
          return InkWell(
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
          );
        }));
  }
}
